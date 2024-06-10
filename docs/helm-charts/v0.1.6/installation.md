!!!warning
    We assume that a database is available to Znuny.  
    Helm charts do not take into account the deployment of this one.

Add the Helm charts repository :

```bash
helm repo add aosc https://helm-charts.aosc-portal.com
```

Install the Helm release :

```bash
helm install znuny aosc/znuny \
  --version 0.1.6 \
  --set config.database.host=postgresql.demo.svc.cluster.local \
  --set config.database.port=5432 \
  --set config.database.name=znuny \
  --set config.database.username=znuny \
  --set config.database.password=password
```


