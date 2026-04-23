## FMR 12 Docker compose

## Composition
- FMR 12 latest on Apache Tomcat 10.1
- MariaDB 12 latest

## Configuration
- The database connection is configured by JNDI referencing the `fmrdatabase` resource in the Tomcat global context.
- Installation is automatically completed applying a default service name and superuser credentials.

## Initial start up
Step 1 - Start the containers.
```bash
docker compose up
```
Step 2 - Navigate to [http://localhost:8179](http://localhost:8179).

Step 3 - Sign on with default superuser credentials username = `root`, password = `password`.

## Stop and restart
Use `Ctrl-C` to stop the running containers while preserving content and settings.

Restart:
```bash
docker compose up
```

## Reinstall from scratch
Reinstall from scratch when you need a fresh installation:
```bash
docker compose down
docker volume rm fmr12-mariadb12-autoinstall_data 
docker compose up
```

