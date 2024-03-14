### Helm release configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| nameOverride                                         | {}                                                   | Overrides the release name |
| namespaceOverride                                    | {}                                                   | Overrides the namespace name |

### ServiceAccount configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| serviceAccount.create                                | true                                                 | Defines whether the ServiceAccount should be created or not |
| serviceAccount.annotations                           | {}                                                   | Defines ServiceAccount annotations |
| serviceAccount.name                                  | ""                                                   | Defines the name of the ServiceAccount |

### Pod strategies configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| imagePullSecrets                                     | []                                                   | Defines the secrets to be used to pull the image |
| restartPolicy                                        | Always                                               | Defines the restart policy |
| deploymentStrategy                                   | Recreate                                             | Defines the deployment behavour |
| replicaCount                                         | 1                                                    | Define the desired number of replicas |

### Image configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| image.repository                                     | ghcr.io/mln-nicolas-b/docker-znuny                   | Defines the name of the image to be used |
| image.tag                                            | v6.5.3-1                                             | Defines the tag of the image to be used |
| image.pullPolicy                                     | IfNotPresent                                         | Defines the pull policy of the image |

### Logs configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.logs                                          | {}                                                   | Defines whether the Znuny application should log to a file and provides the file path. |

### External database configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.database.type                                 | mysql                                                | Defines the type of the external database |
| config.database.host                                 | host                                                 | Defines the host of the external database |
| config.database.port                                 | port                                                 | Defines the port of the external database |
| config.database.name                                 | name                                                 | Defines the name of the external database |
| config.database.user                                 | user                                                 | Defines the connection user of the external database |
| config.database.password                             | password                                             | Defines the connection password of the external database |

### Web server configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.apache.domain                                 | znuny.domain.tld                                     | Defines a ServerName in the virtualhost of the Apache2 server |
| config.apache.rewriteRules                           | {}                                                   | Defines request rewriting rules in the Apache2 server virtualhost |

### Local users configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.users.admin.name                              | root@localhost                                       | Defines the username of the local administrator user |
| config.users.admin.password                          | password                                             | Defines the password of the local administrator user |

### Mailing configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.mails.type                                    | external                                             | Defines the method used to send e-mails |
| config.mails.host                                    | smtp.domain.tld                                      | Defines the SMTP server host |
| config.mails.port                                    | 25                                                   | Defines the SMTP server port |
| config.mails.user                                    | znuny@domain.tld                                     | Defines the SMTP server user name |
| config.mails.password                                | none                                                 | Defines the SMTP server user password |

### Authentications backends configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.authentications.customers.backends            | {}                                                   | Define an authentication backend for customer login |
| config.authentications.customers.synchronizations    | {}                                                   | Defines a synchronization backend for local client storage |
| config.authentications.agents.backends               | {}                                                   | Define an authentication backend for agent login |
| config.authentications.agents.synchronizations       | {}                                                   | Defines a synchronization backend for local client storage |

### Autoscaling configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.autoscaling.minReplicas                       | 1                                                    | Defines the minimum number of replicas for HorizontalPodScaling |
| config.autoscaling.maxReplicas                       | 3                                                    | Defines the maximum number of replicas for HorizontalPodScaling |
| config.autoscaling.targetCPUUtilizationPercentage    | 20                                                   | Defines the CPU threshold to trigger scaling |
| config.autoscaling.targetMemoryUtilizationPercentage | 50                                                   | Defines the RAM threshold to trigger scaling |

### Service configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.service.type                                  | ClusterIP                                            | Defines the type of Kubernetes service |
| config.service.port                                  | 80                                                   | Defines the port of Kubernetes service |

### Ingress configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.ingress.enabled                               | false                                                | Defines whether the Kubernetes Ingress resource should be activated or not |
| config.ingress.domain                                | znuny.domain.tld                                     | Defines the Ingress public domain |
| config.ingress.annotations                           | ["kubernetes.io/ingress.class: nginx"]               | Defines Ingress annotations |
| config.ingress.tls.enabled                           | true                                                 | Defines whether TLS should be enabled on Ingress or not |
| config.ingress.tls.annotations                       | ["cert-manager.io/cluster-issuer: letsencrypt-prod"] | Defines annotations for ingress TLS functionalities |

### Volumes configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.persistentVolumeClaims                        | []                                                   | Defines persistent volumes, their names, their mounting |

### Pod configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.podAnnotations                                | []                                                   | Defines pod annotations |

### Resources configurations

| Option                                               | Default                                              | Description |
|:-----------------------------------------------------|:-----------------------------------------------------|:------------|
| config.resources.limits.cpu                          | 100m                                                 | Defines the pod CPU limit resources |
| config.resources.limits.memory                       | 128Mi                                                | Defines the pod RAM limit resources |
| config.resources.requests.cpu                        | 100m                                                 | Defines the pod CPU request resources |
| config.resources.requests.memory                     | 128Mi                                                | Defines the pod RAM request resources |

