# Note for Maridb
## create network
	docker network create mariadb
## restart after reboot & failure
	docker update --restart unless-stopped mariadb
## check restart status
	docker inspect -f "{{ .HostConfig.RestartPolicy }}"  mariadb
## connect to DB
	. ./passwords && docker exec -it mariadb  mysql -p "$MYSQL_ROOT_PASSWORD"
