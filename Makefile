.PHONY: build
build:
	docker compose build

.PHONY: down
down:
	docker compose down -v

.PHONY: up
up:
	docker compose up -d

.PHONY: top
top:
	docker run --rm -ti \
  		--name=ctop \
  		--volume /var/run/docker.sock:/var/run/docker.sock:ro \
  		quay.io/vektorlab/ctop:latest

.PHONY: logs
logs:
	docker compose logs -f

.PHONY: clean-bucket
clean-bucket:
	rm -fr ./minio_storage/targets-versioned
