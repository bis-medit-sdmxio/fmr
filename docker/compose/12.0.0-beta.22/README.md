## FMR 12 Docker compose

## Initial start up
Step 1 - Start the containers.
```bash
docker compose up
```
Step 2 - Navigate to [http://localhost:8179](http://localhost:8179).

Step 3 - On the database connection page, accept the license agreement and click `Next`.

Step 4 - Choose a password for the 'root' superuser account and click `Next`.

## Reinstall from scratch
Reinstall from scratch when you need a fresh installation:
```bash
docker compose rm -v
docker volume rm fmr12_mysql_data
docker compose up
```
Continue with Steps 2, 3 and 4.

## Stop and restart
Use `Ctrl-C` to stop the running containers while preserving content and settings.

Restart:
```bash
docker compose up
```
