.DEFAULT_GOAL = serve-dev

.PHONY: serve-dev
serve-dev: ## Start a server with development configuration
	jekyll serve --watch --future --config _config.yml,_config_dev.yml

.PHONY: clean
clean: ## Clean-up temporary files (such as Emacs tmp files)
	find . -iname "*~" -type f -delete
	find . -iname "#*~#" -type f -delete

.PHONY: publish-single
publish-single:
	bash publish-single.sh $(FILENAME)
