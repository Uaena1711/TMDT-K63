SHELL := /bin/bash

run: 
	scripts/permiss.sh && docker-compose up -d

build: 
	scripts/permiss.sh && docker-compose up --build

flushredis:
	docker exec -it redis.ghtk.vn redis-cli flushAll

ssh:
	docker exec -it ghtk_php zsh

set-https:
	bin/magento setup:store-config:set --base-url="http://" --base-url-secure="https://" --use-secure=1

deploy_14:
	rsync -avhzL --delete \
				--no-perms --no-owner --no-group \
				--exclude .git \
				--exclude .env \
				--exclude dist \
				--exclude tmp \
				--exclude node_modules \
				--exclude workers \
				--filter=":- .gitignore" \
				/home/sam/Documents/tmdt/TMDT-K63 hai@20.70.76.187:/home/hai/
