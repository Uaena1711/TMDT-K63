SHELL := /bin/bash

run: 
	scripts/permiss.sh && docker-compose up -d

build: 
	scripts/permiss.sh && docker-compose up --build

flushredis:
	docker exec -it redis.ghtk.vn redis-cli flushAll

ssh:
	docker exec -it ghtk_php zsh
rsync:
	rsync -avhzL -e "ssh -i /home/sam/Downloads/quizlet-key.pem" --delete \
                                --no-perms --no-owner --no-group \
                                --exclude .git \
																--filter=":- .gitignore" \
                                . ubuntu@54.254.227.102:/home/ubuntu/TMDT-K63/
