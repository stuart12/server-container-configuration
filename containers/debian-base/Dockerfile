FROM stuart/debian-sid:latest
MAINTAINER Stuart Pook
ENV DEBIAN_FRONTEND=noninteractive
ENV PAGER=/bin/cat

RUN apt-get -q -y --allow-remove-essential purge \
	anacron \
	bash \
	bsdmainutils \
	cpio \
	debconf-i18n \
	gdbm-l10n \
	libcap2-bin \
	nano \
	procps \
	cron \
	cron-daemon \
	dmidecode \
	dmsetup \
	e2fsprogs \
	fdisk \
	ifupdown \
	iproute2 \
	iptables \
	iputils-ping \
	isc-dhcp-client \
	isc-dhcp-common \
	kmod \
	less \
	libargon2-0 \
	libblkid1 \
	login \
	logrotate netbase \
	lsb-base \
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
RUN apt-get update -q -y
RUN apt-get upgrade -q -y --no-install-recommends
RUN apt-get install -q -y --no-install-recommends deborphan
RUN apt-get clean
RUN while list=$(deborphan --guess-all| grep .); do echo purge $list; apt-get purge -y -q $list; done
RUN apt-get -q -y purge deborphan

ENTRYPOINT [ "/bin/sh" ]
LABEL version "0.1"
