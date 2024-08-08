# Fusion Metadata Registry for SDMX
**Fusion Metadata Registry (FMR) is a free to use SDMX structural metadata registry, data modelling platform and data processing engine for official statistics producers, collectors and reporters.**

![image](https://github.com/user-attachments/assets/84f7b40c-6783-413a-8a99-82e77da82c13)


FMR helps official statistics organisations externalise and gain control of their statistical structural metadata with the benefits of maintainability, re-use, standardisation, harmonisation and improved metadata and data governance.

It provides:
- A controlled repository for SDMX structural metadata, which acts as a single source of truth for: automated metadata-driven data processing systems, metadata needed by data providers in data collections, structures for the purposes of standardisation, statistical data harmonisation, and communal benefit.
- Three integrated metadata-driven data processing services: data validation, data transformation (mapping data between structures) and conversion of data between SDMX data formats. 
- Metadata authoring and maintenance web UI, enabling metadata managers to browse, author and maintain their structural metadata model.

Find out more about FMR on [sdmx.io](https://www.sdmx.io/tools/fmr/).

FMR is a [BIS Open Tech](https://www.bis.org/innovation/bis_open_tech.htm) initiative

## 10 minute quick start with Docker
Start by installing [Docker Desktop](https://www.docker.com/products/docker-desktop/) or another container runtime platform like [Podman](https://podman.io/).
> [!NOTE]
> We assume you're using Docker in the following examples.

Download the image from Docker Hub and start a container called 'fmr'.
```bash
docker run --name fmr -p 8080:8080 sdmxio/fmr-mysql:latest
```
The container will take between 1 and 2 minites to start, so please be patient!

There is a single Root User Account:<br>
Username: root<br>
Password: password

Log in to administer the system, and create, load and maintain SDMX structures.

When finished, stop the container
```bash
docker stop fmr
```

## Deploy on a Java web application server
FMR is a Java enterprise web application so can be deployed on an application server like Apache Tomcat or Wildfly on Windows, Linux or Mac.

First assemble the prerequisites needed to run an FMR installation:
- Java runtime such as OpenJDK - version 11 is recommended
- Java web application server - Apache Tomcat 9 is recommended
- SQL database service - FMR supports MySQL 5.7 and 8, MariaDB, SQL Server and Oracle - MariaDB 10 is recommended

Next:
1. Download the FMR 'war' file from the GitHub package repo https://github.com/bis-medit-sdmxio/fmr/releases
2. Deploy the 'war' file to the web application server
3. Using a web browser, navigate to the deployed root URL, for instance `http://localhost:8080`
4. After the FMR application starts, you should see the install pages - complete these with the database connection details and server settings requested

There's more information on how to install and configure FMR on the [wiki](https://fmrwiki.sdmxcloud.org/Quick_start_guide_-_Windows,_Linux_or_Mac). 
