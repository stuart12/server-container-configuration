# A docker image for https://www.exim.org/ (exim4)

FROM stuart/debian-sid:2018.03.31
LABEL version="1.0"
MAINTAINER Stuart Pook

RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -q -y

#http://www.brain-dump.org/blog/entry/40/Creating_dummy_packages_to_fullfill_dependencies_in_Debian
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q --no-install-recommends equivs
RUN cd /tmp && echo Package: exim4-config-2 | equivs-build /dev/stdin && dpkg -i exim4-config-2_1.0_all.deb && rm exim4-config-2_1.0_all.deb
RUN mkdir /var/lib/exim4

RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends exim4-daemon-heavy
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
	ln -s /proc/self/fd/2 /var/log/exim4/log && \
	ln -s /proc/self/fd/2 /var/log/exim4/mainlog && \
	ln -s /proc/self/fd/2 /var/log/exim4/rejectlog && \
	ln -s /proc/self/fd/2 /var/log/exim4/paniclog && \
	chown root /var/log/exim4 && chmod 755 /var/log/exim4 && \
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
