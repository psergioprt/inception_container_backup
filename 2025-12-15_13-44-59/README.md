*This project has been created as part of the 42 curriculum by pauldos-.*
# Description

Inception is a system administration and Docker-oriented project focused on building a small, fully containerized infrastructure.
The goal is to design and deploy a multi-service architecture using **Docker Compose** , where each service runs inside its own dedicated container built from a custom **Dockerfile**.

The project recreates a functional web stack composed of:

- **NGINX** (with TLS support)
- **Wordpress** running with PHP-FPM
- **MariaDB** as the database service

All components interact inside a custom Docker network, and persistent data is stored using Docker volumes.
Through this setup, the project introduces the fundamentals of containerization, service isolation, orchestration, and environment management without relying on prebuilt images.

---

# Instructions

## 1. Requirements
Before running the project, make sure you have:

- Docker installed
- Docker Compose (v.3.8 or compatible)
- A valid **'.env' file** containing the required environment variables (WordPress, MariaDB, domain name, etc).

The '.env' file must be located at:
$(HOME)/env/.env

## 2. Project Setup

Clone the repository and move into the project folder:

```
git clone <repo-url> rootInception
cd rootInception
```
Project structure: 
```
├── DEV_DOC.md
├── Makefile
├── README.md
├── srcs
│   ├── docker-compose.yml
│   └── requirements
│       ├── mariadb
│       │   ├── conf
│       │   │   └── 50-server.cnf
│       │   ├── Dockerfile
│       │   └── mariadb-run.sh
│       ├── nginx
│       │   ├── conf
│       │   │   └── nginx.conf
│       │   └── Dockerfile
│       └── wordpress
│           ├── conf
│           │   └── www.conf
│           ├── Dockerfile
│           └── install_wordpress.sh
└── USER_DOC.md
```
**Important Notes**
+ Throughout this README, whenever you see https://login.42.fr, in my project should be replaced with https://pauldos-.42.fr. This is the domain configured for my Inception setup.
+ Default folders for persistent data (MariaDB and Wordpress) are located under /HOME/pauldos-/ but they may appear as $(HOME)/. Both refer to the same user home directory. 

## 3. Build and Run

The project uses a Makefile to simplify execution (use either)
```
make
make all
```
This will:
+ create MariaDB and Wordpress data folders:
```
  $(HOME)/data/mariadb/*
  $(HOME)/data/wordpress/*
```
+ Build all Docker images
+ Start all services using docker compose

## 4. Start services
```
make up
```
## 5. Stop services

Stops containers:
```
make down
```
Stops containers, removes volumes and orphans containers
(containers from old service definitions no longer present in docker compose).
```
make clean
```
## 6. Clean the environment
```
make fclean
```
This will:
+ Run make clean
+ Remove the WordPress and MariaDB data folders (requires sudo)
+ Removes the .env file (to avoid commiting it by accident)
+ Run Docker prune, commands to delete unused images, networks, stopped containers and build cache.

## 7. Rebuild everything
```
make re
```
Runs make fclean followed by make all.

## 8. Access the website

The website only accepts **HTTPS** connections.
Open:
```
https://login.42.fr
```

# Resources

Besides the help from 42 peers regarding how to begin the project, understand expected behaviours, Docker contruction and overcoming difficulties, I used the following
 resources to better understand Inception project contents:

## Official Documentation
+ Docker Documentation:			https://docs.docker.com
+ Docker Compose Reference:		http://docs.docker.com/compose/
+ Dockerfile Reference:			https://docs.docker.com/engine/reference/builder/
+ NGINX Documentation:			https://nginx.org/en/docs/
+ MariaDB Documentation:		https://mariadb.com/docs
+ WordPress Documentation:		https://developer.wordpress.org/

## Other Resources
+ Getting Started With Markedown:	https://itsfoss.com/markdown-guide/
+ Docker Tutorial:			https://www.tutorialspoint.com/docker/index.htm
+ Docker Tutorial:			https://www.geeksforgeeks.org/devops/docker-tutorial/

## AI Assistance was used to:
+ Clarify Docker concepts (orphans, prune, volumes, networks, Compose, etc).  
+ Explaining configuration behaviour and general Docker workflows.
+ Helping structure and improve the newly required Markedown sections of the project's implementation.

## Features
+ Fully containerized multi-service infrastructure
+ Custom Dockerfiles for each service (no prebuilt images allowed)
+ NGINX configured with TLS/SSL
+ Wordpress running with PHP-FPM
+ MariaDB database with secure initialization
+ Persistent storage with Docker volumes
+ Containers isolated inside a private Docker network
+ Automated setup and management using a Makefile
+ Environment variable configuration through a .env file

## Technical Choices
+ **Docker Compose v.3.8**  
	+ Simplifies orchestration and service management  
	+ Enables persistent volumes and isolated networks  
+ **NGINX + TLS**  
	+ Mandatory HTTPS  
	+ Secure reverse proxy  
	+ Serves static + PHP traffic  
+ **PHP-FPM for WordPress**  
	+ Efficient PHP processing  
	+ Clean separation between web server and application runtime  
+ **MariaDB**  
	+ Open-source relational database  
	+ Configured via init script and custom config(50-server.cnf)  
+ **Volumes under $(HOME)/data/**  
	+ Ensure data persistence  
	+ Keeps state between container rebuilds  
+ **Makefile automation**  
	+ make / make up - start the infrastructure  
	+ make down / make clean - stop and clean orphans  
	+ make fclean - full cleanup, including images/volumes and .env  
	+ make re - rebuild everything  

## Usage Examples
+ Start the full infrastructure
```
make
```
+ Visit the website
```
https://login.42.fr
```
+ View running containers
```
docker compose ps
```
+ Inspect database volume
```
ls $(HOME)/data/mariadb
```
+ Check logs of a service
```
docker logs nginx
docker logs mariadb
docker logs wordpress
```
+ Check which ports are running, tls version, etc
```
curl -Ivk https://login.42.fr
```
+ Example for checking user at wp-users table of the created database
```
docker exec -it mariadb bash
mariadb -u dbuser -p (prompts for password stored at .env file)
use dbsite
select * from wp-users;
```

# Project Description
This project uses Docker to provide lightweight, reproducible, and isolated environments for each service, avoiding the overhead of virtual machines and simplifying deployment and management.

## Concept Comparisons

### Virtual Machines vs Docker

| Feature       | Virtual Machines        | Docker                         |
|---------------|-------------------------|--------------------------------|
| OS            | Full OS per VM          | Shared kernel, containers only |
| Resource Use  | High                    | Low                            |
| Startup Time  | Minutes                 | Seconds                        |
| Deployment    | Less flexible           | Reproducible and fast          |

**Choice:** Docker was chosen for lightweight, fast, and reproducible containerization.

### Secrets vs Environment Variables

| Feature     | Secrets                | Environment Variables        |
|-------------|-----------------------|-------------------------------|
| Security    | Encrypted, safer      | Visible in `.env` or process  |
| Usage       | Sensitive credentials | Service configuration         |
| Persistence | Managed by Swarm/K8s  | Manual file management        |

**Choice:** Environment variables were used for simplicity.

### Docker Network vs Host Network

| Feature        | Docker Network          | Host Network               |
|----------------|-------------------------|----------------------------|
| Isolation      | Full container network  | Shared host network        |
| Port Conflicts | Avoided                 | Risk of conflicts          |
| Flexibility    | High                    | Low                        |

**Choice:** A private Docker network was used for container isolation and communication.

### Docker Volumes vs Bind Mounts

| Feature       | Volumes                    | Bind Mounts                     |
|---------------|----------------------------|---------------------------------|
| Location      | Managed by Docker          | Maps host folder directly       |
| Persistence   | Survives container removal | Survives container removal      |
| Portability   | High                       | Tied to host path               |
| Accessibility | Inside Docker only         | Directly accessible on the host |

**Choice:** Bind mounts were used for MariaDB and WordPress data to ensure persistence, easy host access, and direct inspection or backup of files.
