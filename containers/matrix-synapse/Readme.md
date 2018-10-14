# Hints

## build the image
	docker build --tag matrix-synapse .
## run the image
	docker stop matrix-synapse ; docker rm matrix-synapse ; docker run --publish 8448:8448 --restart unless-stopped --name matrix-synapse --detach --network postgresql --mount source=matrix-media,destination=/var/lib/matrix-synapse/media --init matrix-synapse && docker network connect proxy matrix-synapse

	docker run --mount source=matrix-media,destination=/var/lib/matrix-synapse/media --interactive --tty matrix-synapse sh -i  
	docker exec --interactive --tty matrix-synapse /bin/sh
	docker logs --follow matrix-synapse

## connect to nginx proxy
	docker network connect proxy matrix-synapse

## create a user
	docker exec --interactive --tty matrix-synapse register_new_matrix_user -c /etc/matrix-synapse/conf.d/registration.yaml -u <person> -p <password> http://localhost:8008
