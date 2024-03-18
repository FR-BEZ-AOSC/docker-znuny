## Quick start

The deployment of the development stack is managed with [Docker Compose](https://docs.docker.com/compose).  

Create the file ***docker-compose.dev.yaml*** at the root of the project :

```yaml
---
version: "3"

networks:
  net:

volumes:
  pgsql:

services:
  app:
    build:
      context: .
      dockerfile: ./znuny/Dockerfile
    image: ghcr.io/fr-bez-aosc/znuny:alpha-6.1.1
    container_name: znuny
    environment:
      ZNUNY_DATABASE_TYPE: pgsql
      ZNUNY_DATABASE_HOST: postgresql
      ZNUNY_DATABASE_PORT: 5432
      ZNUNY_DATABASE_NAME: znuny
      ZNUNY_DATABASE_USER: znuny
      ZNUNY_DATABASE_PASSWORD: password
    networks:
      - net
    ports:
      - 8080:80
    depends_on:
      - db
  db:
    image: bitnami/postgresql:16
    container_name: postgresql
    user: root
    environment:
      POSTGRES_DB: znuny
      POSTGRES_USER: znuny
      POSTGRES_PASSWORD: password
      POSTGRESQL_POSTGRES_PASSWORD: password
    volumes:
      - pgsql:/bitnami/postgresql/data
    networks:
      - net
    ports:
      - 5432:5432
```

After editing the file ***docker-compose.dev.yaml***, deploy the database :

```bash
docker compose -f docker-compose.dev.yaml up -d db
```

Check the deployment like this :

```bash
docker compose logs -f db
```

Then, alter the privileges of the role Znuny :

```bash
docker compose exec -ti db psql -h 127.0.0.1 -U postgres -d znuny -p 5432 -c "ALTER ROLE znuny WITH SUPERUSER;"
```

Finally, deploy Znuny :

```bash
docker compose -f docker-compose.dev.yaml up -d app
```

Check the deployment like this :

```bash
docker compose logs -f app
```



