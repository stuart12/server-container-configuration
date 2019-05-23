# Hints
## build the image
	docker build --tag postgresql .
## run the image
	docker run --mount source=postgresql-db,destination=/var/lib/postgresql --init postgresql
	docker run --mount source=postgresql-db,destination=/var/lib/postgresql --interactive --tty --entrypoint=/bin/sh postgresql
core@stuart1 ~/github.com/server-container-configuration/containers $ docker network create postgresql
core@stuart1 ~/github.com/server-container-configuration/containers $ docker network connect postgresql d7d65715e340e5a9ce4f7aa4f194a6ddc9c678723c3d4f3ddd311a7174f31ab1
## Run a command in a running container
	docker exec -it 9284140ed558a2a4d4880c13f5994664c4cbf1fdf38e4dd91750f5c64d080104 /bin/sh
	docker exec -it postgresql /bin/sh
## create user etc
	docker exec -i  postgresql createuser matrix --pwprompt
	docker exec -ti  postgresql createdb matrix
	docker exec -i postgresql  psql
		grant all privileges on database mozillasync to mozillasync;
	docker exec -i postgresql  psql
		 alter user  "matrix-synapse" with  ENCRYPTED password 'foobar';
	bzip2 -d < ~/postgres.dump.bz2 | docker exec -i postgresql psql  --set ON_ERROR_STOP=on matrix
## check & set restart policy
	docker inspect -f "{{ .HostConfig.RestartPolicy }}" postgresql
	docker update  --restart=unless-stopped postgresql
