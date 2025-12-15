# 1. Overview of the Provided Services

This project deploys a fully containerized web hosting stack using Docker and Docker Compose.
The following services are available:

**NGINX** — HTTPS reverse proxy serving the website.

**WordPress + PHP-FPM** — The CMS and administration interface.

**MariaDB** — Relational database storing WordPress content.

All services run inside isolated containers and communicate through a private Docker network.
Persistent data is stored inside Docker volumes located in $(HOME)/data/.

# 2. How to Start and stop the Project

The project is managed using the Makefile at the root of the repository.

Start everything:
```
make
```
or:
```
make up
```
This will:

Create the required data folders

Build the custom Docker images

Launch all services with Docker Compose

Stop containers:
```
make down
```
Stop and remove orphans:
```
make clean
```
Full cleanup (images, volumes, and .env removed):
```
make fclean
```
# 3. How to Access the Website
Visit the main website:
https://pauldos-.42.fr

WordPress admin panel:
https://pauldos-.42.fr/wp-admin

Credentials come from the .env file

# 4. Locating and Managing Credentials

All credentials are stored in the .env file located at:

```
$(HOME)/env/.env
```
This includes:

WordPress admin username, password, and email

MariaDB database name, user, and passwords

The configured domain (pauldos-.42.fr)

This file must NOT be pushed to Git.

# 5. Checking That the Services Are Running Correctly
Check container status:
docker compose ps

Check logs:
docker logs nginx
docker logs mariadb
docker logs wordpress

Test HTTPS and connection:
curl -Ivk https://pauldos-.42.fr

Check MariaDB manually:
docker exec -it mariadb bash
mariadb -u DB_USER -p
SHOW DATABASES;


If all containers appear as “Up” in docker compose ps, the stack is functioning correctly.
