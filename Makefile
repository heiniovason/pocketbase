.PHONY: up health logs build down clean restart u h l b d c r n

up:
	docker compose up --detach

health:
	docker inspect --format='{{json .State.Health}}' backend | jq

logs:
	docker compose logs --follow

build:
	docker compose up --build --detach

down:
	docker compose down

# Too avoid running sudo. Docker daemon runs with root privileges.
JANITOR = docker run --rm -v $(shell pwd):/app alpine:latest sh -c

clean:
	docker compose down --remove-orphans
	@echo "Removing Pocketbase bind-mount data ..."
	$(JANITOR) "rm -rf pb_data/*"
	@echo "Pocketbase bind/mount data removed."

# Also remove caddy conf + cert
nuke:
	@echo "Nuking all volumes and containers ..."
	docker compose down -v
	@echo "Nuking confirmed."
	@$(MAKE) clean

restart: clean up

# aliases
u: up
h: health
l: logs
b: build
d: down
c: clean
n: nuke
r: restart
