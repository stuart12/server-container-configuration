# dovecot: A docker image for https://www.dovecot.org/

FROM stuart/debian-sid:2018-05-28
LABEL maintainer "Stuart Pook"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -q
RUN adduser --force-badname --system --no-create-home --uid 945 --group --gecos 'share with exim4 container' Debian-exim
RUN apt-get dist-upgrade -q -y

EXPOSE 143

ENV USERS /etc/dovecot/users

RUN set -x && \
	apt-get update -q && \
	apt-get --allow-remove-essential --quiet --yes --auto-remove purge \
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

RUN set -x && \
	apt-get install -q -y --no-install-recommends dovecot-imapd && \
	apt-get clean && \
	apt-get auto-remove -y && \
	apt-get --purge -q -y --allow-remove-essential remove \
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

LABEL version "1.3"
