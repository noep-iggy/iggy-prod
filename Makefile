help:
	@echo "Liste des commandes disponibles :"
	@grep -E '^[1-9a-zA-Z_-]+(\.[1-9a-zA-Z_-]+)?:.*?## .*$$|(^#--)' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m %-43s\033[0m %s\n", $$1, $$2}' \
	| sed -e 's/\[32m #-- /[33m/'

#-- GENERAL

create: ## Create
	cp .env.exemple .env && docker compose up -d

#-- START
start: ## Start
	docker start iggy-back && docker start iggy-db && docker start iggy-backoffice

#-- STOP
api.stop: ## Stop api
	docker stop iggy-back && docker stop iggy-db

backoffice.stop: ## Stop backoffice
	docker stop iggy-backoffice

#-- RESTART
restart.api: ## Restart
	make api.delete && make create

restart.backoffice: ## Restart
	make backoffice.delete && make create

restart.all: ## Restart
	make api.delete && docker image rm noephilippe/iggy-backoffice && make create

#-- DELETE

api.delete: ## Delete
	docker compose down && docker volume rm iggy-prod_upload && docker volume rm iggy-prod_db && docker image rm noephilippe/iggy-back

backoffice.delete: ## Delete
	docker compose down && docker volume rm iggy-prod_upload && docker volume rm iggy-prod_db && docker image rm noephilippe/iggy-backoffice
	
#-- LOGS

api.logs: ## Show api logs
	docker logs iggy-back -f

backoffice.logs: ## Show backoffice logs
	docker logs iggy-backoffice -f