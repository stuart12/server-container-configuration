# Hints
## build the base image
    sudo bash -x /usr/share/docker.io/contrib/mkimage.sh -t stuart/debian debootstrap --variant=minbase sid
    sudo docker images
    sudo docker save 4799523 | bzip2 | pv | ssh hh 'bunzip2 | docker load'

## build the image
	docker build --tag matrix-synapse --build-arg TURN_SECRET=turnit --build-arg DATABASE_PASSWORD=dbfoo .
## run the image
	docker run --interactive --tty matrix-synapse sh -i  
