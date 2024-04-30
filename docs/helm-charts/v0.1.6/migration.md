## Migrate an existing instance on a new one

Create the job manifest file "./job.migration.yaml" using the following as an example :

```yaml
---
apiVersion: batch/v1
kind: Job
metadata:
  name: znuny-migration-db2db
spec:
  template:
    spec:
      containers:
        - name: zcli
          image: ghcr.io/fr-bez-aosc/znuny:<tag>
          envFrom:
          - configMapRef:
              name: znuny-config
          - secretRef:
              name: znuny-secrets
          command:
            - "/usr/bin/zcli"
            - "job"
            - "migration"
            - "database"
            - "-h"
            - "postgresql.default.svc.cluster.local"    # The kubernetes domain of the remote database
            - "-p"
            - "5432"                                    # The port exposed by the kubernetes service
            - "-n"
            - "znuny"                                   # The name of the remote database
            - "-u"
            - "znuny"                                   # The user used for the remote connection
            - "-w"
            - "password"                                # The user's password used for the remote connection
      restartPolicy: Never
```

> Make sure the image used is the same version as the target deployment.

Stop the new instance :

```bash
kubectl patch deployment znuny \
  -n demo \
  -p '{"spec": {"replicas": 0}}'
```

Migrate migrate the database :

```bash
kubectl create \
  -n demo \
  -f ./tests/job.migration.yaml
```

Restart the new instance :

```bash
kubectl patch deployment znuny \
  -n demo \
  -p '{"spec": {"replicas": 1}}'
```

If desired, delete the migration job :

```bash
kubectl delete \
  -n demo \
  -f ./tests/job.migration.yaml
```
