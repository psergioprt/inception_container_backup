# Default target: build and start containers
all: build up

re: fclean build up

# Ensure persistent data directories exist
data:
	mkdir -p $(HOME)/data/mariadb
	mkdir -p $(HOME)/data/wordpress
	cp $(HOME)/env/.env $(HOME)/rootInception/srcs/

# Build Docker images (depends on data folders)
build: data
	docker compose -f srcs/docker-compose.yml build --no-cache

# Start containers in detached mode
up:
	docker compose -f srcs/docker-compose.yml up -d

# Stop containers
down:
	docker compose -f srcs/docker-compose.yml down

# Show logs
logs:
	docker compose -f srcs/docker-compose.yml logs -f

# Remove all containers, networks, and volumes (optional cleanup)

rm_data:
	@sudo rm -rf $(HOME)/data/mariadb
	@sudo rm -rf $(HOME)/data/wordpress

rm_env:
	rm -f $(HOME)/rootInception/srcs/.env

prune:
	docker system prune -af --volumes

clean:
	docker compose -f srcs/docker-compose.yml down -v --remove-orphans

fclean: clean rm_data rm_env prune

.PHONY: all re data build up down logs rm_data rm_env prune clean fclean
