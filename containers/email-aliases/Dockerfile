# docker image to add aliases to exim

FROM stuart/debian-sid:2018.03.31
MAINTAINER Stuart Pook
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --quiet && \
	apt-get dist-upgrade --quiet --yes && \
	apt-get auto-remove --yes && \
	apt-get install --quiet --yes --no-install-recommends \
		python3 \
		openssh-server \
	&& true

RUN \
	apt-get --quiet --yes --auto-remove --allow-remove-essential purge \
	e2fsprogs \
	fdisk \
	login \
	mount \
	man-db \
	bsdmainutils \
	bsdutils \
	hostname \
	&& rm -r /var/lib/apt/lists/*

ARG USER=editor
ARG SCRIPT=/usr/local/bin/email-aliases
RUN adduser --uid 2000 --shell $SCRIPT --gecos "Edit Aliases" --disabled-password --no-create-home $USER
RUN mkdir -m 555 /home/$USER
RUN chgrp $USER /etc/ssh/ssh_host_*_key && chmod 640 /etc/ssh/ssh_host_*_key
ARG SSH_PUBLIC_KEYS=/etc/ssh_public_keys
COPY conf/ssh_public_keys $SSH_PUBLIC_KEYS
COPY conf/sshd_config /etc/sshd_config
ARG PORT=2222
EXPOSE $PORT
RUN echo Port $PORT >> /etc/sshd_config
RUN echo AllowUsers $USER >> /etc/sshd_config
RUN echo AuthorizedKeysFile $SSH_PUBLIC_KEYS >> /etc/sshd_config
COPY scripts/email-aliases $SCRIPT
RUN chmod 755 $SCRIPT

USER $USER
ENTRYPOINT [ "/usr/sbin/sshd", \
	"-D", \
	"-e", \
	"-f", "/etc/sshd_config" \
]
LABEL version="0.0"
