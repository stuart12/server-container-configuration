# hints

[Docker + Nginx + LetsEncrypt](https://miki725.github.io/docker/crypto/2017/01/29/docker+nginx+letsencrypt.html)

	docker build --tag myproxy . && docker stop proxy && docker rm proxy && ./start-proxy && docker logs --follow proxy

	docker run --cap-drop=all --interactive --tty --rm --volume letsencrypt-etc:/etc/letsencrypt --volume letsencrypt-run:/run/letsencrypt deliverous/certbot certonly --webroot --webroot-path=/run/letsencrypt --email ${LETS_ENCRYPT_EMAIL?'define LETS_ENCRYPT_EMAIL'} --no-eff-email --domains matrix.pook.it,hh.pook.it,nextcloud.pook.it,ffsync.pook.it,imap3.pook.it,smtp3.pook.it,etesync.pook.it

## view letsencrypt volumes

	docker run --rm -it -v letsencrypt-run:/run/letsencrypt -v letsencrypt-etc:/etc/letsencrypt stuart/debian-sid:latest bash -i

## renew
	docker run --rm --volume letsencrypt-etc:/etc/letsencrypt --volume letsencrypt-run:/run/letsencrypt deliverous/certbot renew --webroot --webroot-path=/run/letsencrypt --email ${EMAIL?'define EMAIL'} --no-eff-email

	openssl s_client -connect hh.pook.it:443 -tls1 -tlsextdebug -status < /dev/null | grep OCSP

[Sharing volume between docker containers](https://stackoverflow.com/questions/37000341/sharing-volume-between-docker-containers)

## check options for nginx in ldocker image
	docker run -t nginx:latest nginx -V

[nginx: [emerg] 1#1: mail directive is not allowed here](https://stackoverflow.com/questions/47296679/nginx-emerg-11-mail-directive-is-not-allowed-here-in-etc-nginx-conf-d-de)

# check starttls
	(https://halon.io/blog/how-to-test-smtp-servers-using-the-command-line/)[How to test SMTP servers using the command-line]
	openssl s_client -connect proxy:143 -starttls imap


[Markdown: Syntax](https://daringfireball.net/projects/markdown/syntax)
