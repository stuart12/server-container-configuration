# docker image to add aliases to exim

FROM stuart/debian-sid:latest
MAINTAINER Stuart Pook
ENV DEBIAN_FRONTEND=noninteractive

RUN true && \
	apt-get update --quiet && \
	apt-get dist-upgrade --quiet --yes && \
	apt-get auto-remove --yes && \
	apt-get install --quiet --yes --no-install-recommends \
		openssh-server \
		python3-minimal \
		&& \
	apt-get --quiet --yes --auto-remove --allow-remove-essential purge \
		bsdmainutils \
		bsdutils \
		e2fsprogs \
		fdisk \
		hostname \
		login \
		man-db \
		mount \
		&& \
	rm -r /var/lib/apt/lists/* && \
	true

ARG USER=editor
ARG SCRIPT=/usr/local/bin/email-aliases
RUN adduser --uid 2000 --shell $SCRIPT --gecos "Edit Aliases" --disabled-password --no-create-home $USER
RUN mkdir -m 555 /home/$USER
ARG SSHD_CONFIG=/etc/ssh/sshd_config
ARG AUTHORIZED_KEYS=/etc/ssh_public_keys
COPY conf/ssh_public_keys $AUTHORIZED_KEYS
COPY conf/sshd_config $SSHD_CONFIG
ARG PORT=2222
EXPOSE $PORT
RUN echo Port $PORT >> $SSHD_CONFIG
RUN echo AllowUsers $USER >> $SSHD_CONFIG
RUN echo AuthorizedKeysFile $AUTHORIZED_KEYS >> $SSHD_CONFIG
COPY scripts/email-aliases $SCRIPT
RUN chmod 755 $SCRIPT

ARG HOST_KEYS=/media/ssh-host-keys
RUN true && \
	mkdir -m 755 $HOST_KEYS && \
	mv /etc/ssh/ssh_host_*_key $HOST_KEYS/ && \
	chgrp $USER $HOST_KEYS/* && \
	chmod 640 $HOST_KEYS/* && \
	ls $HOST_KEYS/* | sed -e 's/^/HostKey /' >> $SSHD_CONFIG && \
	true
VOLUME $HOST_KEYS

USER $USER
ENTRYPOINT [ "/usr/sbin/sshd", \
	"-e", \
	"-D" \
]
LABEL version="1.1"
