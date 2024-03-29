help:
	@echo "Liste des commandes disponibles :"
	@grep -E '^[1-9a-zA-Z_-]+(\.[1-9a-zA-Z_-]+)?:.*?## .*$$|(^#--)' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m %-43s\033[0m %s\n", $$1, $$2}' \
	| sed -e 's/\[32m #-- /[33m/'

#-- GENERAL

create: ## Create
	cp .env.exemple .env && docker compose up -d

#-- START
start.api: ## Start api
	docker start iggy-db && docker start iggy-back

start.backoffice: ## Start backoffice
	docker start iggy-backoffice

start.all: ## Start
	docker start iggy-db && docker start iggy-back && docker start iggy-backoffice

#-- STOP
stop.api: ## Stop api
	docker stop iggy-back && docker stop iggy-db

stop.backoffice: ## Stop backoffice
	docker stop iggy-backoffice

#-- RESTART
restart.api: ## Restart
	make delete.api && make create

restart.backoffice: ## Restart
	make delete.backoffice && make create

restart.all: ## Restart
	make delete.api && docker image rm noephilippe/iggy-backoffice && make create

#-- CLEAN
clean.api: ## Clean
	docker compose down && docker volume rm iggy-prod_db iggy-prod_upload && docker compose up -d

#-- DELETE

delete.api: ## Delete
	docker compose down && docker image rm noephilippe/iggy-back

delete.backoffice: ## Delete
	docker compose down && docker image rm noephilippe/iggy-backoffice

delete.all: ## Delete
	docker compose down && docker image rm noephilippe/iggy-back && docker image rm noephilippe/iggy-backoffice
	
#-- LOGS

logs.api: ## Show api logs
	docker logs iggy-back -f

logs.backoffice: ## Show backoffice logs
	docker logs iggy-backoffice -f