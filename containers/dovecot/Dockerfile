# dovecot: A docker image for https://www.dovecot.org/

FROM stuart/debian-sid:2018.03.31
LABEL maintainer "Stuart Pook"

RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -q -y

EXPOSE 143

ENV USERS /etc/dovecot/users

RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends dovecot-imapd
RUN apt-get clean
RUN apt-get auto-remove -y
RUN apt-get --purge -q -y --allow-remove-essential remove \
	e2fsprogs \
	fdisk \
	login \
	mount \
	&& true

COPY conf.d /etc/dovecot/conf.d/
# just user:passwd in $USERS
COPY users $USERS
RUN echo log_path = /dev/stdout > /etc/dovecot/conf.d/10-logging.conf
RUN addgroup --gid 500 vmail
RUN adduser --disabled-password --disabled-login --no-create-home --uid 500 --gid 500 --gecos 'Virtual Email User' vmail

VOLUME /mail

ENTRYPOINT [ "/usr/sbin/dovecot", "-F" ]

VOLUME /var/sockets

LABEL version "1.2"
