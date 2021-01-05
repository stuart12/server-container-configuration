# EteSync: https://www.etesync.com/
# Secure, End-to-End encrypted and journalized personal information synchronization.
# A Dockerfile for etebase-v2

# use any Debian sid image
FROM stuart/debian-sid:latest
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
	true
RUN set -x && \
	apt-get install -q -y --no-install-recommends \
		git-core \
		python3-asgiref \
		python3-cffi \
		python3-h11 \
		python3-click \
		python3-dotenv \
		python3-httptools \
		python3-nacl \
		python3-pip \
		python3-pycparser \
		python3-setuptools \
		python3-six \
		python3-typing-extensions \
		python3-uvloop \
		python3-watchgod \
		python3-websockets \
		python3-wheel \
		python3-yaml \
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
	git clone https://github.com/etesync/server.git $PROGRAM_DIR && \
	pip3 install -r $PROGRAM_DIR/requirements.txt && \
	true

RUN apt-get purge -y -q git-core && apt-get auto-remove -y -q

ARG USER=etesync
ARG DB_DIR=/db

ARG CONFIG=etebase-server.ini

RUN set -x && \
	adduser --system --group --uid 900 $USER && \
	cd $PROGRAM_DIR && \
	sed -e '/^allowed_host1 /s/=.*/ = etesync.pook.it/' -e "/^name = db/s@=.*@= $DB_DIR/etesync.sqlite3@" $CONFIG.example > $CONFIG && \
	diff $CONFIG.example $CONFIG | grep . && \
	dd bs=40 count=1 if=/dev/urandom status=none | sha1sum | cut -f1 -d ' ' > secret.txt && \
	chown $USER secret.txt && \
	: Set secret.txt not readable so etesync will create a new secret each time it is run && \
	chmod 200 secret.txt && \
	true

RUN mkdir -m 700 $DB_DIR && chown $USER $DB_DIR && date > $DB_DIR/etesync-db-container
VOLUME $DB_DIR

ENV LISTEN_PORT=8000
EXPOSE $LISTEN_PORT

USER $USER
ENTRYPOINT [ "/bin/sh" ]
WORKDIR $PROGRAM_DIR
CMD [ "-xc", "/usr/bin/python3 manage.py migrate && exec uvicorn etebase_server.asgi:application --host 0.0.0.0 --port $LISTEN_PORT" ]

LABEL version "2.0"
