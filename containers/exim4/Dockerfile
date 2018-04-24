# A docker image for https://www.exim.org/ (exim4)

FROM stuart/debian-sid:2018.03.31
MAINTAINER Stuart Pook

RUN addgroup --system --gid 376 letsencrypt
RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -q -y

#http://www.brain-dump.org/blog/entry/40/Creating_dummy_packages_to_fullfill_dependencies_in_Debian
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q --no-install-recommends equivs
RUN cd /tmp && echo Package: exim4-config-2 | equivs-build /dev/stdin && dpkg -i exim4-config-2_1.0_all.deb && rm exim4-config-2_1.0_all.deb
RUN mkdir /var/lib/exim4

RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends exim4-daemon-heavy
RUN adduser Debian-exim letsencrypt
RUN apt-get clean

RUN apt-get auto-remove -y
RUN apt-get --purge -q -y --allow-remove-essential remove \
	e2fsprogs \
	fdisk \
	login \
	mount \
	&& true

EXPOSE 25 587

RUN \
	chown root:Debian-exim /var/log/exim4 && \
	ln -s /dev/stderr /var/log/exim4/log && \
	ln -s /dev/stderr /var/log/exim4/mainlog && \
	ln -s /dev/stderr /var/log/exim4/rejectlog && \
	ln -s /dev/stderr /var/log/exim4/paniclog && \
	true

VOLUME /mail

COPY exim4 /etc/exim4

USER Debian-exim

ENTRYPOINT [ "/usr/sbin/exim4" ]
CMD [ \
	"-q30m", \
	#"-d-all+ident" , \
	"-v", \
	"-bd" \
]
LABEL version="1.1"
