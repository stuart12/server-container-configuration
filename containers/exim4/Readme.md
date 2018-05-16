# Notes for exim4 docker container
## Authentification
	echo -ne '\0'$USER'\0my-password' | base64
	telnet exim4 587
	ehlo iii
	auth plain AHN0dWFydABkZGRkZGRkZGRk
	235 Authentication succeeded

## Docker Hints
### shell in the container
	docker exec --tty --interactive --user root exim4 bash

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

## checkout [swaks](https://linux.die.net/man/1/swaks) & [mail-tester](https://www.mail-tester.com/)
	swaks --silent 1 --server smtp3.pook.it:587 --tls --auth-user $AS --auth-password "$PASSWD" --to $COOKIE@mail-tester.com --from someone587@pook.it --header "Subject: hello $(date)" --body "hello Web, the computers are very slow today, Fred"
	swaks --silent 1 --server smtp3.pook.it:587 --tls --auth-user $AS --auth-password "$PASSWD" --to $AS@acm.org --from dummy587@pook.it --header "Subject: 587 $(date)"
	swaks --silent 1 --server smtp3.pook.it:25  --tls  --to $AS@pook.it --from dummy25@pook.it --header "Subject: port 25 $(date)"


### a free DKIM mail tester
[dkimvalidator.com](http://dkimvalidator.com/)
http://dkim.org/specs/draft-allman-dkim-base-01.html
https://dkimcore.org/c/keycheck

### DMAC Setup
[globalcyberalliance.org](https://dmarcguide.globalcyberalliance.org)
[mxtoolbox.com](https://mxtoolbox.com/SuperTool.aspx?action=dmarc%3apook.it&run=networktools)
