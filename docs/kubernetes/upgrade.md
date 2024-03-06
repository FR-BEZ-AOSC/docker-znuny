Create the job manifest file "./job.upgrade.yaml" using the following as an example :

```yaml
---
apiVersion: batch/v1
kind: Job
metadata:
  name: znuny-upgrade-6.1.1
spec:
  template:
    spec:
      containers:
        - name: zcli
          image: ghcr.io/fr-bez-aosc/znuny:beta-6.1.1
          envFrom:
          - configMapRef:
              name: znuny-config
          - secretRef:
              name: znuny-secrets
          command:
            - "/usr/bin/zcli"
            - "job"
            - "upgrade"
      restartPolicy: Never
```

> Make sure the image used is the same version as the target deployment.

Stop the instance :

```bash
kubectl patch deployment znuny \
  -n demo \
  -p '{"spec": {"replicas": 0}}'
```

Upgrade database schemas :

```bash
kubectl create \
  -n demo \
  -f ./tests/job.upgrade.yaml
```

Restart the instance :

```bash
kubectl patch deployment znuny \
  -n testcharts \
  -p '{"spec": {"replicas": 1}}'
```

If desired, delete the upgrade job :

```bash
kubectl delete \
  -n testcharts \
  -f ./tests/job.upgrade.yaml
```
