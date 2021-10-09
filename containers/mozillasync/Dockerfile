# https://github.com/mozilla-services/syncserver

# use any Debian sid image
FROM stuart/debian-sid:latest
ARG USER=builder
LABEL maintainer "Stuart Pook"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q 
RUN apt-get --allow-remove-essential --quiet --yes --auto-remove purge \
		cpio \
		debconf-i18n \
		dmidecode \
		dmsetup \
		ifupdown \
		init \
		iproute2 \
		iptables \
		iputils-ping \
		isc-dhcp-common \
		kmod \
		less \
		logrotate \
		nano \
		procps \
		rsyslog \
		tasksel \
		whiptail \
		xxd \
		&& \
	apt-get upgrade --no-install-recommends -q -y && \
	true
RUN apt-get install -q -y --no-install-recommends \
	ca-certificates \
	git-core \
	make \
	g++ \
	libpq-dev \
	&& true
RUN apt-get install -q -y --no-install-recommends \
	python2-dev \
	python-setuptools \
	&& true
RUN apt-get install -q -y --no-install-recommends \
	libmariadb-dev \
	&& true
RUN sed -e 's/sid/oldstable/' /etc/apt/sources.list > /etc/apt/sources.list.d/oldstable.list
RUN apt-get update -q 
RUN apt-get install -q -y --no-install-recommends \
	python-virtualenv \
	python-grpcio \
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
ARG BuildPkgs="\
	g++ \
	git-core \
	libpq-dev \
	make \
	python2-dev \
"

USER root
RUN apt-get install -q -y --no-install-recommends \ 
	libmariadb3 \
	libpq5 \
	python2.7 \
	&& true

RUN apt-get --quiet --yes --auto-remove purge $BuildPkgs
RUN apt-get clean

ARG USER=syncserver
RUN adduser --disabled-password --disabled-login --no-create-home --uid 1024 --gecos 'Mozila Syncserver' $USER
ARG CONFIG=/etc/syncserver.ini

#COPY --from=0 /opt/syncserver /opt/syncserver
#COPY --from=0 /opt/syncserver/syncserver /opt/syncserver/syncserver
#COPY --from=0 /opt/syncserver/local /opt/syncserver/local
#COPY --from=0 /opt/syncserver/syncserver.egg-info /opt/syncserver/syncserver.egg-info
#COPY --from=0 /opt/syncserver/syncserver.wsgi /opt/syncserver/.
RUN cp /opt/syncserver/syncserver.ini $CONFIG
RUN sed -i -e "s/#secret =.*/secret = $(head -c 20 /dev/urandom | sha1sum | sed -e 's/ .*//')/" $CONFIG
RUN sed -i -e '/^public_url = /s@= .*@= https://mozillasync.pook.it@' $CONFIG
RUN sed -i -e '/allow_new_users/s/^# *//' $CONFIG
ARG DBPASSWD
RUN sed -i -e '/^#sqluri = sq/s^.*^sqluri = postgresql://mozillasync:'"$DBPASSWD"'@postgresql:5432/mozillasync^' $CONFIG
#RUN echo sqluri = "postgresql://mozillasync:$DBPASSWD@postgresql:5432/mozillasync" >> $CONFIG
#RUN echo public_url = https://mozillasync.pook.it >> $CONFIG
RUN sed -i -e '/^workers/s/.*/workers = 2/' $CONFIG
RUN sed -i -e '/^timeout/s/.*/timeout = 60/' $CONFIG
WORKDIR /opt/syncserver
RUN cat $CONFIG

# http://docs.gunicorn.org/en/stable/settings.html
RUN echo "exec ./local/bin/gunicorn --log-level debug --forwarded-allow-ips=127.0.0.1,192.168.42.2 --paste $CONFIG syncserver.wsgi_app" > /opt/syncserver/start.sh
RUN cat $CONFIG
USER $USER
ENTRYPOINT [ "/bin/sh" ]
CMD [ "-xc", ". /opt/syncserver/start.sh" ]

EXPOSE 5000
LABEL version "1.3"
