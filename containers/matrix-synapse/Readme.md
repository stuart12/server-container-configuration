# Hints

## redirect to matrix server
This configuration also requires creating
https://pook.it/.well-known/matrix/server which must contain
`{"m.server":"matrix.pook.it"}`.

## build the image
	docker build --tag matrix-synapse .
## run the image
	docker stop matrix-synapse ; docker rm matrix-synapse ; docker run --publish 8448:8448 --restart unless-stopped --name matrix-synapse --detach --network postgresql --mount source=matrix-media,destination=/var/lib/matrix-synapse/media --init matrix-synapse && docker network connect proxy matrix-synapse

## run the image without starting matrix

	docker run --mount source=matrix-media,destination=/var/lib/matrix-synapse/media --interactive --tty matrix-synapse sh -i  

## run a shell in a running container
	docker exec --interactive --tty matrix-synapse /bin/sh

## follow the logs
	docker logs --follow matrix-synapse

## connect to nginx proxy
	docker network connect proxy matrix-synapse

## create a user
	docker exec --interactive --tty matrix-synapse register_new_matrix_user -c /etc/matrix-synapse/conf.d/registration.yaml -u <person> -p <password> http://localhost:8008

## get matrix-synapse version
	docker exec --interactive --tty matrix-synapse dpkg --list matrix-synapse
or
    docker run -it --rm --volume matrix-media:/mnt --network proxy stuart/debian-sid:latest bash -i
    apt update && apt install -y curl && curl -I http://matrix-synapse:8008/_matrix/client/r0/login

## get list of rooms
    docker exec --tty -i postgresql psql -P pager=off --dbname=matrix -c "SELECT room_id from rooms"

## check federation setup
Run [Matrix Federation Tester](https://matrix.org/federationtester/) on `pook.it`.

[Matrix Federation Tester API](https://matrix.org/federationtester/api/report?server_name=pook.it)

# TODO
- generate a new registration key at each server start
