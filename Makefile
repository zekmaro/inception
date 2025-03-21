YML_FILE = srcs/docker-compose.yml

upd:
	docker compose -f $(YML_FILE) up -d

up:
	docker compose -f $(YML_FILE) up

down:
	docker compose -f $(YML_FILE) down

build:
	docker compose -f $(YML_FILE) build

re:
	docker compose -f $(YML_FILE) down
	docker compose -f $(YML_FILE) up --build -d

clean:
	docker system prune -a

nuke:
	docker compose -f $(YML_FILE) down -v
	docker system prune -a --volumes

ps:
	docker compose -f $(YML_FILE) ps -a

logs:
	docker compose -f $(YML_FILE) logs -f