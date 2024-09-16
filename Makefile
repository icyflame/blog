.DEFAULT_GOAL = help
CONTAINER_NAME = blog
CWD = $(shell pwd)
PORT = 4000

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":"} \
		/^[a-zA-Z0-9_-]+:( ## [a-zA-Z0-9 _-]+)?$$/ { \
		sub("\\n", "", $$2); \
		sub(/ +## +/, "", $$2); \
		printf "%-30s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: docker-serve-dev
docker-serve-dev: ## Start development server by running a Docker container
	docker container rm -f $(CONTAINER_NAME)
	docker run --detach --name $(CONTAINER_NAME) --volume $(CWD):/src -w /src -p $(PORT):$(PORT) blog:latest /usr/bin/tail -f
	docker exec $(CONTAINER_NAME) make serve-dev BINDTO=0.0.0.0

.PHONY: docker-build-image
docker-build-image: ## Build Docker image for the blog
	docker build -t blog:latest .

.PHONY: clean
clean: ## Clean-up temporary files (such as Emacs tmp files)
	docker container rm -f $(CONTAINER_NAME)
