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
                                . ubuntu@54.169.74.238:/home/ubuntu/TMDT-K63/
