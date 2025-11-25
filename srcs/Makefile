# Makefile for Inception project
# Usage: make [all|build|up|down|logs]

include .env

# Default target: build and start containers
all: clean build up

# Ensure persistent data directories exist
data:
	@if [ ! -d "/home/paulo/data/mariadb" ] && [ ! -d "/home/paulo/data/wordpress" ]; then \
    		mkdir -p /home/paulo/data/mariadb && mkdir -p /home/paulo/data/wordpress; \
	fi

# Build Docker images (depends on data folders)
build: data
	docker compose build --no-cache

# Start containers in detached mode
up:
	docker compose up -d

# Stop containers
down:
	docker compose down -v

# Show logs
logs:
	docker compose logs -f

# Remove all containers, networks, and volumes (optional cleanup)
clean:
	docker compose down -v --remove-orphans

