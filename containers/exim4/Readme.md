# Notes for exim4 docker container
## Authentification
	echo -ne '\0stuart\0my-password'  | base64
	telnet exim4 587
	ehlo iii
	auth plain AHN0dWFydABkZGRkZGRkZGRk
	235 Authentication succeeded

## Docker Hints
### shell in the container
	docker exec -it exim4 bash

### connect with ssl
	openssl s_client -connect exim4:587 -starttls smtp

## checkout [swaks](https://linux.die.net/man/1/swaks)
