# hints

[Docker + Nginx + LetsEncrypt](https://miki725.github.io/docker/crypto/2017/01/29/docker+nginx+letsencrypt.html)

	docker-compose up -d

	docker run --name="test" -it -v nginx_certs-run:/run/letsencrypt debian /bin/cat /run/letsencrypt/index.html
	docker run -it -v nginx_certs-run:/run/letsencrypt debian /bin/cat /run/letsencrypt/index.html

[Sharing volume between docker containers](https://stackoverflow.com/questions/37000341/sharing-volume-between-docker-containers)


[Markdown: Syntax](https://daringfireball.net/projects/markdown/syntax)
