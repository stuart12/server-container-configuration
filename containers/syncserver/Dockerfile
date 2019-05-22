# https://github.com/mozilla-services/syncserver

# use any Debian sid image
FROM stuart/debian-base
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
	&& true
WORKDIR /opt
RUN git clone https://github.com/mozilla-services/syncserver
WORKDIR /opt/syncserver
RUN make build test

# https://docs.docker.com/develop/develop-images/multistage-build/
FROM stuart/debian-base

RUN apt-get update -q 
RUN apt-get dist-upgrade -q -y
RUN apt-get install -q -y --no-install-recommends python2.7
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
#RUN echo allow_new_users = false >> $CONFIG
ARG DBPASSWD
RUN echo sqluri_ = postgresql://mozillasync:$DBPASSWD@postgresql:5432/mozillasync >> $CONFIG
RUN echo sqluri = sqlite:////tmp/syncserver.db >> $CONFIG
WORKDIR /opt/syncserver

USER $USER
ENTRYPOINT [ "/bin/sh" ]
CMD [ "-xc", "exec ./local/bin/gunicorn --forwarded-allow-ips=127.0.0.1,172.17.0.1 --paste /etc/syncserver.ini syncserver.wsgi_app" ]

LABEL version "1.1"
