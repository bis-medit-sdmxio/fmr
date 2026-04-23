## FMR 12 Docker compose

## Composition
- FMR 12 latest on Apache Tomcat 10.1
- MariaDB 12 latest
- Keycloak 26

## Overview
This compose definition deploys a fully installed FMR 12 service integrated with a Keycloak instance for user identity management.

A MariaDB database provides FMR 12 content storage.

## Use cases
The intended use cases are testing, training, evalulation and as a starting point for developing production deployments.

**Importantly, it's not designed for production use.** Keycloak in particular is configured to start in 'development' mode which simplifies deplyoment by avoiding the need for a separate database and HTTPS, but takes several shortcuts.

## Configuration
### FMR 
- Service URL: `http://localhost:8179`
- The database connection is configured by JNDI referencing the `fmrdatabase` resource in the Tomcat global context.
- Installation is automatically completed applying a default service name and superuser credentials. 
- Authentication is also automatically configured to use the integrated Keycloak OIDC service's `fmr` realm.
- And FMR's Role Based Access Control (RBAC) is initialised to assign Administrator privilges to members of the Keycloak 'admins' group.
### Keycloak
- Service URL: `http://localhost:8178`
- Management endpoint: `http://localhost:9000` (e.g. for observing service [health](https://www.keycloak.org/observability/health))
- The service is started in [development mode](https://www.keycloak.org/server/configuration#_starting_keycloak_in_development_mode) using the `-start-dev` parameter.
- There is no separate database container - Keycloak defaults to its internal H2 database which persists content to the `keycloak_data` mounted volume.
- An example realm and client registration, together with two example users and groups is imported on initial startup.
### Mounted volumes
There are two persistent mounted volumes:
- `fmr_data` FMR's MariaDB database content
- `keycloak_data` Keycloak content

Note that in practice, the volume names are prefixed with the Compose configuration name which means that they default to `fmr12-mariadb12-keycloak-autoinstall_fmr_data` and `fmr12-mariadb12-keycloak-autoinstall_keycloak_data`.

## Pre-configured accounts and credentials
### FMR
- Root superuser account: username = `root`, password = `password`
### Keycloak `fmr` realm
- Demo FMR administrator: username = `admin`, password = `password`, group membership = `admins`
- Demo metadata maintainer: username = `maintainer`, password = `password`, group membersip = `maintainers`
### Keycloak administration
- Default admin: username = `admin`, password = `admin`

## Initial start up
Step 1 - Start the containers.
```bash
docker compose up
```
Step 2 - Navigate to the FMR UI homepage [http://localhost:8179](http://localhost:8179).

Step 3 - Sign on using either the FMR superuser account (Login with credentials option), or the 'fmr' realm's `admin` account (Login with SSO option).

Step 4 - Sign into the Keycloak console to adminster the 'fmr' realm [http://localhost:8178](http://localhost:8178).

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
docker volume rm fmr12-mariadb12-keycloak-autoinstall_keycloak_data 
docker volume rm fmr12-mariadb12-keycloak-autoinstall_fmr_data
docker compose up
```

