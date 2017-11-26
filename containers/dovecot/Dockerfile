# A docker image for https://www.dovecot.org/

FROM alpine:latest
LABEL version="1.0"
MAINTAINER Stuart Pook
ENV USERS /etc/dovecot/users
# must match homedir in $USERS
ENV HOME_FS /mail

RUN apk add --no-cache dovecot bash
#RUN echo ssl = no > /etc/dovecot/conf.d/10-ssl.conf
#RUN echo disable_plaintext_auth = no > /etc/dovecot/conf.d/11-auth.conf
COPY conf.d/10-master.conf /etc/dovecot/conf.d/10-master.conf
COPY users $USERS
RUN echo log_path = /dev/stdout > /etc/dovecot/conf.d/10-logging.conf

RUN mkdir -m 755 $HOME_FS
RUN sed -ne 's/[^:]*:[^:]*:\([^:]*\):\([^:]*\):[^:]*:\([^:]*\):.*/mkdir -m 700 \3; chown \1:\2 \3/p' $USERS | sh -xe
VOLUME $HOME_FS

ENTRYPOINT [ "/usr/sbin/dovecot", "-F" ]
ENTRYPOINT exec bash

EXPOSE 143
