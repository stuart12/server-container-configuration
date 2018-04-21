# https://miki725.github.io/docker/crypto/2017/01/29/docker+nginx+letsencrypt.html
FROM nginx:latest
COPY ./conf /etc/nginx
COPY ./www /data/www
EXPOSE 80 443 143
LABEL version="0.46"
LABEL maintainer="Stuart Pook"
RUN echo 'include /etc/nginx/root.d/*.conf;' >> /etc/nginx/nginx.conf
