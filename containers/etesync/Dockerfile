# EteSync: https://www.etesync.com/
# Secure, End-to-End encrypted and journalized personal information synchronization.

# use any Debian sid image
FROM stuart/debian-sid:2018-05-28
LABEL maintainer "Stuart Pook"

RUN set -x && \
	apt-get update -q && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get dist-upgrade -q -y && \
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
	apt-get install -q -y --no-install-recommends \
		git-core \
		python3-pip \
		python3-setuptools \
		&& \
	apt-get clean && \
	apt-get auto-remove -y && \
	apt-get --purge -q -y --allow-remove-essential remove \
		bash \
		e2fsprogs \
		fdisk \
		login \
		mount \
		&& \
	true

ARG PROGRAM_DIR=/etesync

RUN set -x && \
	umask 22 && \
	git clone https://github.com/etesync/server-skeleton.git $PROGRAM_DIR && \
	pip3 install -r $PROGRAM_DIR/requirements.txt && \
	true

ARG USER=etesync

RUN set -x && \
	adduser --system --group --uid 900 $USER && \
	cd $PROGRAM_DIR && \
	sed -i -e '/^ALLOWED_HOSTS/s/.$/"etesync.pook.it"&/' etesync_server/settings.py && \
	dd bs=40 count=1 if=/dev/urandom status=none | sha1sum | cut -f1 -d ' ' > secret.txt && \
	chown $USER secret.txt && \
	: Set secret.txt not readable so etesync will create a new secret each time it is run && \
	chmod 200 secret.txt && \
	true

ARG DB_DIR=/db

RUN mkdir -m 700 $DB_DIR && chown $USER $DB_DIR && date > $DB_DIR/etesync-db-container
VOLUME $DB_DIR
ENV ETESYNC_DB_PATH=$DB_DIR/etesync.sqlite3

ENV LISTEN_PORT=8000
EXPOSE $LISTEN_PORT

USER $USER
ENTRYPOINT [ "/bin/sh" ]
WORKDIR $PROGRAM_DIR
CMD [ "-xc", "/usr/bin/python3 manage.py migrate && exec /usr/bin/python3 manage.py runserver 0.0.0.0:$LISTEN_PORT" ]

LABEL version "1.1"