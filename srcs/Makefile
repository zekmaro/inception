upd:
	docker compose up -d

up:
	docker compose up

down:
	docker compose down

build:
	docker compose build

re:
	docker compose down
	docker compose up --build -d

clean:
	docker system prune -a

nuke:
	docker compose down -v
	docker system prune -a --volumes

ps:
	docker compose ps -a

logs:
	docker compose logs -f