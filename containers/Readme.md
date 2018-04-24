# General setup for (docker) containers
## Start network
## General hints for (docker) containers
### shell in a network
	docker run -it --rm --network proxy stuart/debian-sid:2018.03.31
		apt update && apt install -y -q telnet openssl


