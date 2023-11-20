help:
	@echo "Liste des commandes disponibles :"
	@grep -E '^[1-9a-zA-Z_-]+(\.[1-9a-zA-Z_-]+)?:.*?## .*$$|(^#--)' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m %-43s\033[0m %s\n", $$1, $$2}' \
	| sed -e 's/\[32m #-- /[33m/'

#-- PROJECT
start:  ## Start project
	cp .env.exemple .env && docker-compose up -d

stop: ## Stop production
	docker stop iggy-back && docker stop iggy-db

delete: ## Delete production
	docker-compose -f docker-compose.yml down && rm -rf ./db_data

logs: ## Show logs production
	docker logs iggy-back

#-- UBUNTU

ubuntu.start: ## Start ubuntu
	cp .env.exemple .env && docker compose up -d

ubuntu.stop: ## Stop ubuntu
	docker stop iggy-back && docker stop iggy-db

ubuntu.delete: ## Delete ubuntu
	sudo docker compose down && sudo rm -rf ./db_data && sudo rm -rf ./public/files/ && sudo docker image rm noephilippe/iggy-back

ubuntu.logs: ## Show logs ubuntu
	docker logs iggy-back -f