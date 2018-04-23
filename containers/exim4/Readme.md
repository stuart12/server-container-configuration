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
