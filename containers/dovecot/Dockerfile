# A docker image for https://www.dovecot.org/

FROM stuart/debian-sid:2018.03.31
LABEL maintainer "Stuart Pook"

RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -q -y

EXPOSE 143

ENV USERS /etc/dovecot/users
# must match homedir in $USERS
ENV HOME_FS /mail

RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends dovecot-imapd
RUN apt-get clean
RUN apt-get auto-remove -y

COPY conf.d /etc/dovecot/conf.d/
COPY users $USERS
RUN echo log_path = /dev/stdout > /etc/dovecot/conf.d/10-logging.conf

RUN mkdir -m 755 $HOME_FS
RUN sed -ne 's/[^:]*:[^:]*:\([^:]*\):\([^:]*\):[^:]*:\([^:]*\):.*/mkdir -m 700 \3; chown \1:\2 \3/p' $USERS | sh -xe
VOLUME $HOME_FS

ENTRYPOINT [ "/usr/sbin/dovecot", "-F" ]

VOLUME /var/sockets

LABEL version "1.1"
