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

.PHONY: serve-dev
serve-dev: ## Start a server with development configuration
	bundle exec jekyll serve --watch --future --config _config.yml,_config_ymd.yml,_config_dev.yml 2>&1 > /dev/null -H $(BINDTO) -P $(PORT)

.PHONY: clean
clean: ## Clean-up temporary files (such as Emacs tmp files)
	find . -iname "*~" -type f -delete
	find . -iname "#*~#" -type f -delete

.PHONY: publish-single
publish-single: ## Publish a single Org file
	bash publish-single.sh $(FILENAME)

.PHONY: docker-serve-dev
docker-serve-dev: ## Start development server by running a Docker container
	docker container rm -f $(CONTAINER_NAME)
	docker run --detach --name $(CONTAINER_NAME) --volume $(CWD):/src -w /src -p $(PORT):$(PORT) blog:latest /usr/bin/tail -f
	# Get the IP address of a docker container on the host
	# https://stackoverflow.com/a/20686101
	docker exec $(CONTAINER_NAME) make serve-dev BINDTO=$(shell docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(CONTAINER_NAME))

.PHONY: docker-build-image
docker-build-image: ## Build Docker image for the blog
	docker build -t blog:latest .
