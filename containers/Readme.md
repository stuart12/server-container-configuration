# General setup for (docker) containers
## General hints for (docker) containers
### shell in a network
	docker run -it --rm --network proxy stuart/debian-sid:2018.03.31
		apt update && apt install -y -q telnet openssl

## Check space
	docker system df -v && docker system df

## remove exited containers
### list
	docker ps -a -f status=exited
### remove
	docker rm $(docker ps -a -f status=exited -q)

## dangling images
	docker images -f dangling=true
	docker image prune

## dangling volumes
### show dangling volumes
	docker volume ls --filter dangling=true
### check when volume last mounted
	docker volume inspect xxxxx

### clean up docker disk usage
make sure all containers are running before running this command

[https://docs.docker.com/engine/reference/commandline/system_prune/](docker system prune)
    docker system prune --volumes

## create base docker image

[https://docs.docker.com/develop/develop-images/baseimages/](Create a base image)
    wget https://raw.githubusercontent.com/moby/moby/master/contrib/mkimage/debootstrap
    chmod 755 debootstrap
    sudo ./debootstrap sid sid
    sudo tar --xz -C sid -c . | ssh hh docker import - stuart/debian-sid:$(date --rfc-3339=date)
    ssh hh docker tag stuart/debian-sid:$(date --rfc-3339=date) stuart/debian-sid:latest
