# hints

[Docker + Nginx + LetsEncrypt](https://miki725.github.io/docker/crypto/2017/01/29/docker+nginx+letsencrypt.html)

	docker rm myproxy && docker build --tag myproxy . && dpcker rm proxy && ./start-proxy

	docker run --interactive  --publish 80:80 --publish 443:443 --volume letsencrypt-etc:/etc/letsencrypt:ro --volume letsencrypt-run:/run/letsencrypt myproxy
	docker run --interactive --tty --rm --volume letsencrypt-etc:/etc/letsencrypt --volume letsencrypt-run:/run/letsencrypt deliverous/certbot certonly --staging --webroot --webroot-path=/run/letsencrypt --email ${EMAIL?'define EMAIL'} --no-eff-email --domains hh.pook.it,nextcloud.pook.it
	docker run --rm -it -v letsencrypt-run:/run/letsencrypt -v letsencrypt-etc:/etc/letsencrypt debian

	openssl s_client -connect hh.pook.it:443 -tls1 -tlsextdebug -status < /dev/null | grep OCSP



[Sharing volume between docker containers](https://stackoverflow.com/questions/37000341/sharing-volume-between-docker-containers)


[Markdown: Syntax](https://daringfireball.net/projects/markdown/syntax)
