## PosgresSQL

Our Helm package does not manage the database, so it must be installed before Znuny is deployed.  
Nous recommandons d'utiliser l'image PostgreSQL de fourie et maintenue par Bitnami.

Add Bitnami's Helm repository :

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Create the custom values file "./values.postgresql.yaml" using the following as an example :

```yaml
image:
  registry: docker.io
  repository: bitnami/postgresql
  tag: 16
  pullPolicy: IfNotPresent

auth:
  enablePostgresUser: false
  postgresPassword: "password"
  username: "znuny"
  password: "password"
  database: "znuny"

primary:
  resources:
    requests:
      cpu: 1
      memory: 512Mi
    limits:
      cpu: 2
      memory: 1024Mi
  persistence:
    enabled: true
    storageClass: ""
    size: 10Gi
    accessModes:
      - ReadWriteOnce
```

Install the Helm release :

```bash
helm upgrade --install postgresql bitnami/postgresql \
  --namespace demo \
  --values ./values.postgresql.yaml
```

> We assume the namespace already exists

Once the deployment is complete, a few operations must be performed to allow Znuny to deploy correctly.  
if the PostgreSQL administrator user's password is not known, retrieve it as follows :

```bash
export POSTGRES_ADMIN_PASSWORD=$(kubectl get secret --namespace testcharts postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
```

Then elevate the privileges of the user used by the application to ensure error-free deployment of Znuny :

```bash
kubectl run postgresql-client \
  --rm -tty --stdin \ 
  --restart='Never' \
  --namespace testcharts \
  --image docker.io/bitnami/postgresql:16 \
  --env="PGPASSWORD=$POSTGRES_ADMIN_PASSWORD" \
  --command -- psql \
    --host postgresql \
    -U postgres \
    -d znuny \
    -p 5432 \
    -c "ALTER ROLE znuny WITH SUPERUSER;"
```

> The name of the role to act on depends on the value of auth.username value used when deploying PostgreSQL

## Znuny

Add Eviden's Helm repository :

```bash
helm repo add aosc https://helm-charts.aosc-portal.com
```

Create the custom values file "./values.znuny.yaml" using the following as an example :

```yaml
replicaCount: 1

image:
  repository: ghcr.io/fr-bez-aosc/znuny
  tag: beta-6.1.1
  pullPolicy: IfNotPresent

config:
  database:
    host: postgresql.demo.svc.cluster.local
    port: 5432
    name: znuny
    user: znuny
    password: password
```

Install the Helm release :

```bash
helm install znuny aosc/znuny \
  --namespace aosc \
  --values ./values.znuny.yaml
```


