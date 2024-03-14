## Quick start

The deployment of the development stack is managed with [Docker Compose](https://docs.docker.com/compose).  

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
    environment:
      PGDATA: /var/lib/postgresql/data/pgdata
      POSTGRES_DB: znuny
      POSTGRES_USER: znuny
      POSTGRES_PASSWORD: password
    volumes:
      - pgsql:/var/lib/postgresql/data/pgdata
    networks:
      - net
    ports:
      - 8080:80
```

After editing the file ***docker-compose.yaml***, just deploy the stack.

```bash
docker-compose up
```

