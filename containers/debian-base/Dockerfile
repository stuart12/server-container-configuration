FROM stuart/debian-sid:latest
MAINTAINER Stuart Pook
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -q -y --allow-remove-essential purge \
	anacron \
	bash \
	bsdmainutils \
	cron \
	cron-daemon \
	dmidecode \
	dmsetup \
	e2fsprogs \
	fdisk \
	fdisk \
	ifupdown \
	iproute2 \
	iptables \
	iputils-ping \
	isc-dhcp-client \
	isc-dhcp-common \
	kmod \
	login \
	login \
	logrotate netbase \
	mount \
	netbase \
	rsyslog \
	sensible-utils \
	systemd \
	systemd-sysv \
	tasksel \
	tasksel-data \
	util-linux \
	whiptail \
	xxd \
	xz-utils \
	&& true
RUN apt-get -y -q --purge autoremove
RUN apt-get update -q
RUN apt-get dist-upgrade -q -y
RUN apt-get clean

ENTRYPOINT [ "/bin/sh" ]
LABEL version "0.0"
