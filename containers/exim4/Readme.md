# Notes for exim4 docker container
## Authentification
	echo -ne '\0stuart\0my-password' | base64
	telnet exim4 587
	ehlo iii
	auth plain AHN0dWFydABkZGRkZGRkZGRk
	235 Authentication succeeded

## Docker Hints
### shell in the container
	docker exec -it exim4 bash

### connect with ssl
	openssl s_client -connect exim4:587 -starttls smtp

### check aliases file
	docker run --volume exim4:/exim --rm -it stuart/debian-sid:2018.03.31 bash

### run shell in the networl
	docker run --network proxy  --rm -it  stuart/debian-sid:2018.03.31 bash

## GPG Keys
export a [public key](http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/) for each user than you want to encrypt incoming messages for
and put them in the keys directory
	gpg --list-keys
	gpg --export -armor you@example.org

## checkout [swaks](https://linux.die.net/man/1/swaks)
