# https://docs.docker.com/engine/examples/postgresql_service
FROM stuart/debian-sid:2018.03.31
MAINTAINER Stuart Pook
EXPOSE 5432
ARG version=10

RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -q -y --no-install-recommends
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends postgresql-10
RUN apt-get --purge -q -y --allow-remove-essential remove \
	bash \
	e2fsprogs \
	fdisk \
	login \
	mount \
	&& true
RUN apt-get autoremove
RUN apt-get clean

RUN echo host all all 0.0.0.0/0 md5 >> /etc/postgresql/10/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf
VOLUME ["/var/lib/postgresql"]

USER postgres

RUN mkdir -m 755 /var/run/postgresql/10-main.pg_stat_tmp

ENTRYPOINT ["/usr/lib/postgresql/10/bin/postgres"]
CMD ["-D", "/var/lib/postgresql/10/main", "-c", "config_file=/etc/postgresql/10/main/postgresql.conf"]
