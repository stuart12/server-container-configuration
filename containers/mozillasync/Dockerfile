# https://github.com/mozilla-services/syncserver

# use any Debian sid image
FROM stuart/debian-base
ARG USER=builder
LABEL maintainer "Stuart Pook"
EXPOSE 5000

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q 
RUN apt-get dist-upgrade -q -y
RUN apt-get install -q -y --no-install-recommends \
	git-core \
	python2.7-dev \
	python-virtualenv \
	make \
	g++ \
	libpq-dev \
	&& true
WORKDIR /opt
RUN adduser --disabled-password --disabled-login --no-create-home --uid 1023 --gecos Builder $USER
RUN chown $USER /opt
USER $USER
RUN git clone https://github.com/mozilla-services/syncserver
WORKDIR /opt/syncserver
RUN make build test
RUN ./local/bin/pip install psycopg2

# https://docs.docker.com/develop/develop-images/multistage-build/
FROM stuart/debian-base

RUN apt-get update -q 
RUN apt-get dist-upgrade -q -y
RUN apt-get install -q -y --no-install-recommends python2.7 libpq5
RUN apt-get clean

ARG USER=syncserver
RUN adduser --disabled-password --disabled-login --no-create-home --uid 1024 --gecos 'Mozila Syncserver' $USER
ARG CONFIG=/etc/syncserver.ini

#COPY --from=0 /opt/syncserver /opt/syncserver
COPY --from=0 /opt/syncserver/syncserver /opt/syncserver/syncserver
COPY --from=0 /opt/syncserver/local /opt/syncserver/local
COPY --from=0 /opt/syncserver/syncserver.egg-info /opt/syncserver/syncserver.egg-info
COPY --from=0 /opt/syncserver/syncserver.wsgi /opt/syncserver/.
COPY --from=0 /opt/syncserver/syncserver.ini $CONFIG
RUN head -c 20 /dev/urandom | sha1sum | sed -e 's/ .*//' -e 's/^/secret = /' >> $CONFIG
RUN echo allow_new_users = false >> $CONFIG
ARG DBPASSWD
RUN echo sqluri = "postgresql://mozillasync:$DBPASSWD@postgresql:5432/mozillasync" >> $CONFIG
RUN sed -i -e '/^public_url/d' $CONFIG
RUN echo public_url = https://mozillasync.pook.it >> $CONFIG
RUN sed -i -e '/^workers/s/.*/workers = 2/' $CONFIG
RUN sed -i -e '/^timeout/s/.*/timeout = 60/' $CONFIG
RUN sed -e '/^#/d' -e '/^$/d' $CONFIG
WORKDIR /opt/syncserver

# http://docs.gunicorn.org/en/stable/settings.html
RUN echo "exec ./local/bin/gunicorn --log-level debug --forwarded-allow-ips=127.0.0.1,192.168.42.2 --paste $CONFIG syncserver.wsgi_app" > /opt/syncserver/start.sh
USER $USER
ENTRYPOINT [ "/bin/sh" ]
CMD [ "-xc", ". /opt/syncserver/start.sh" ]

LABEL version "1.2"
