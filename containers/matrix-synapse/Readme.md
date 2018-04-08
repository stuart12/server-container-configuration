# Hints
## build the base image
[create a Debian image for Docker](https://wiki.debian.org/Cloud/CreateDockerImage)
    sudo /usr/share/docker.io/contrib/mkimage.sh -t $USER/debian debootstrap --variant=minbase sid
    sudo docker save $USER/debian | bzip2 | pv | ssh hh 'bunzip2 | docker load'

## build the image
	docker build --tag matrix-synapse --build-arg TURN_SECRET=turnit --build-arg DATABASE_PASSWORD=dbfoo .
## run the image
	docker run --mount source=matrix-media,destination=/var/lib/matrix-synapse/media --init matrix-synapse
	docker run --mount source=matrix-media,destination=/var/lib/matrix-synapse/media --interactive --tty matrix-synapse sh -i  
