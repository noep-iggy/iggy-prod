help:
	@echo "Liste des commandes disponibles :"
	@grep -E '^[1-9a-zA-Z_-]+(\.[1-9a-zA-Z_-]+)?:.*?## .*$$|(^#--)' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m %-43s\033[0m %s\n", $$1, $$2}' \
	| sed -e 's/\[32m #-- /[33m/'

#-- MAC
mac.start:  ## Start project
	cp .env.exemple .env && docker-compose up -d

mac.stop: ## Stop production
	docker stop iggy-back && docker stop iggy-db

mac.delete: ## Delete production
	docker-compose -f docker-compose.yml down && docker volume rm iggy-prod_upload && docker volume rm iggy-prod_db && docker image rm noephilippe/iggy-back

mac.logs: ## Show logs production
	docker logs iggy-back -f

#-- UBUNTU

start: ## Start ubuntu
	cp .env.exemple .env && docker compose up -d

stop: ## Stop ubuntu
	docker stop iggy-back && docker stop iggy-db

delete: ## Delete ubuntu
	docker compose down && docker volume rm iggy-prod_upload && docker volume rm iggy-prod_db && docker image rm noephilippe/iggy-back

logs: ## Show logs ubuntu
	docker logs iggy-back -f