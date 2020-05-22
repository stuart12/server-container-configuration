# A dockerfile for postgresql

# https://docs.docker.com/engine/examples/postgresql_service
FROM stuart/debian-sid:latest
LABEL maintainer "Stuart Pook"
EXPOSE 5432

RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -q -y --no-install-recommends
ARG USER=postgres
ARG version=12
ENV version $version
RUN adduser --disabled-password --disabled-login --no-create-home --uid 1023 --gecos PostgreSQL $USER
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends postgresql-$version
RUN apt-get --purge -q -y --allow-remove-essential remove \
	bash \
	e2fsprogs \
	fdisk \
	login \
	mount \
	&& true
RUN apt-get autoremove
RUN apt-get clean

COPY script /script

RUN echo host all all 0.0.0.0/0 md5 >> /etc/postgresql/$version/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/$version/main/postgresql.conf
VOLUME ["/var/lib/postgresql"]

USER $USER

ENTRYPOINT ["/bin/sh"]
CMD ["/script", "/var/lib/postgresql"]

LABEL version "1.2"
