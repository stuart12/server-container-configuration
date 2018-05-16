# A docker image for https://www.exim.org/ (exim4)

FROM stuart/debian-sid:2018.03.31
MAINTAINER Stuart Pook
EXPOSE 25 587

RUN addgroup --system --gid 376 letsencrypt
RUN apt-get update -q && \
	DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -q -y && \
	DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
		equivs \
		gpg \
		libmail-gnupg-perl \
		libmime-tools-perl \
		ca-certificates \
		wget \
	&& true

#http://www.brain-dump.org/blog/entry/40/Creating_dummy_packages_to_fullfill_dependencies_in_Debian
RUN cd /tmp && \
	echo Package: exim4-config-2 | equivs-build /dev/stdin && \
	dpkg -i exim4-config-2_1.0_all.deb && \
	rm exim4-config-2_1.0_all.deb && \
	mkdir -m 755 /var/lib/exim4 && \
	DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends exim4-daemon-heavy
RUN apt-get clean

RUN adduser Debian-exim letsencrypt
RUN wget --quiet --output-document /usr/local/bin/gpgit.pl https://gitlab.com/mikecardwell/gpgit/raw/33e5a08edc935b6fc678941beb663de12d023b63/gpgit.pl
RUN chmod 755 /usr/local/bin/gpgit.pl

RUN \
	chown root:Debian-exim /var/log/exim4 && \
	ln -s /dev/stderr /var/log/exim4/log && \
	ln -s /dev/stderr /var/log/exim4/mainlog && \
	ln -s /dev/stderr /var/log/exim4/rejectlog && \
	ln -s /dev/stderr /var/log/exim4/paniclog && \
	true

RUN addgroup --gid 500 vmail
RUN adduser --disabled-password --disabled-login --uid 500 --gid 500 --gecos 'Virtual Email User' vmail

VOLUME /var/spool/exim4
COPY keys /tmp/keys
ARG EMAIL_OWNER=vmail
RUN chown -R $EMAIL_OWNER /tmp/keys
ARG DKIM_VOL=/etc/exim-dkim
ARG DKIM_PRIV=$DKIM_VOL/dkim_rsa.private

ARG EXIM_USER=Debian-exim
RUN \
	mkdir -m 2755 $DKIM_VOL && \
	chgrp $EXIM_USER $DKIM_VOL && \
	openssl genrsa -out $DKIM_PRIV 2048 && \
	openssl rsa -in $DKIM_PRIV -out $DKIM_VOL/dkim_rsa.public -pubout -outform PEM && \
	chmod 640 $DKIM_PRIV && \
	true
VOLUME /etc/exim-dkim

RUN apt-get --quiet --yes --auto-remove --allow-remove-essential purge \
	wget \
	e2fsprogs \
	fdisk \
	login \
	mount \
	man-db \
	findutils \
	bsdmainutils \
	bsdutils \
	hostname \
	&& true
RUN apt-get auto-remove --yes
COPY exim4 /etc/exim4
RUN sed -i -e "/^ *dkim_private_key/s@DKIM_PRIV-replaced-by-Dockerfile@$DKIM_PRIV@" /etc/exim4/exim4.conf

USER $EMAIL_OWNER
RUN /usr/local/bin/gpgit.pl --help > /dev/null
RUN gpg --import /tmp/keys/* && rm -r /tmp/keys

USER $EXIM_USER
ENTRYPOINT [ "/usr/sbin/exim4" ]
CMD [ \
	"-q5m", \
	#"-d-all+ident" , \
	"-v", \
	"-bd" \
]
LABEL version="1.7"
