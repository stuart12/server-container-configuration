# Hints
## build the base image
[create a Debian image for Docker](https://wiki.debian.org/Cloud/CreateDockerImage)
    sudo /usr/share/docker.io/contrib/mkimage.sh -t $USER/debian debootstrap --variant=minbase sid
    sudo docker save $USER/debian | bzip2 | pv | ssh hh 'bunzip2 | docker load'

## build the image
	docker build --tag matrix-synapse .
## run the image
	docker stop matrix-synapse ; docker rm matrix-synapse ; docker run --publish 8448:8448 --restart unless-stopped --name matrix-synapse --detach --network postgresql --mount source=matrix-media,destination=/var/lib/matrix-synapse/media --init matrix-synapse && docker network connect proxy matrix-synapse

	docker run --mount source=matrix-media,destination=/var/lib/matrix-synapse/media --interactive --tty matrix-synapse sh -i  
	docker exec --interactive --tty matrix-synapse /bin/sh
	docker logs --follow matrix-synapse

## connect to nginx proxy
	docker network connect proxy matrix-synapse
