.DEFAULT_GOAL = help

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":"} \
		/^[a-zA-Z0-9_-]+:( ## [a-zA-Z0-9 _-]+)?$$/ { \
		sub("\\n", "", $$2); \
		sub(/ +## +/, "", $$2); \
		printf "%-30s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: serve-dev
serve-dev: ## Start a server with development configuration
	bundle exec jekyll serve --watch --future --config _config.yml,_config_dev.yml 2>&1 > /dev/null &

.PHONY: stop-serve-dev
stop-serve-dev: ## Stop the development server
	pkill --full jekyll

.PHONY: clean
clean: ## Clean-up temporary files (such as Emacs tmp files)
	find . -iname "*~" -type f -delete
	find . -iname "#*~#" -type f -delete

.PHONY: publish-single
publish-single: ## Publish a single Org file
	bash publish-single.sh $(FILENAME)
