FROM stuart/debian-sid:latest
MAINTAINER Stuart Pook
EXPOSE 8448
EXPOSE 8008
ENV DOMAIN=pook.it
ENV SYNAPSE_CACHE_FACTOR=0.01
ARG DATABASE_PASSWORD
ARG TURN_SECRET

RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -q -y
RUN adduser --system --home /var/lib/matrix-synapse --uid 800 --group matrix-synapse
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends matrix-synapse python-psycopg2
RUN apt-get --purge -q -y --allow-remove-essential remove \
	bash \
	e2fsprogs \
	fdisk \
	login \
	mount \
	&& true
RUN apt-get clean

COPY synapse /etc/matrix-synapse/conf.d
COPY keys/homeserver.tls.dh /etc/matrix-synapse/
COPY keys/homeserver.tls.crt /etc/matrix-synapse/
COPY keys/homeserver.tls.key /etc/matrix-synapse/
COPY keys/homeserver.signing.key /etc/matrix-synapse/
COPY keys/turn_secret.yaml /etc/matrix-synapse/conf.d/
COPY keys/macaroon_secret_key.yaml /etc/matrix-synapse/conf.d/
COPY keys/database.yaml /etc/matrix-synapse/conf.d/
COPY config/log-stdout.yaml /etc/matrix-synapse/
COPY scripts/start /start
RUN echo 'server_name: "'$DOMAIN'"' > /etc/matrix-synapse/conf.d/server.yaml
#RUN (echo -n 'macaroon_secret_key: "'; tr -dc '[#-[_-~!]' < /dev/urandom | dd status=none bs=50 count=1; echo '"') > /etc/matrix-synapse/conf.d/macaroon.yaml
RUN (echo -n 'registration_shared_secret: "'; tr -dc '[#-[^~!]' < /dev/urandom | dd status=none bs=6 count=7; echo '"') > /etc/matrix-synapse/conf.d/registration.yaml
RUN echo 'turn_uris: ["turn:turn.'$DOMAIN':3478?transport=udp", "turn:turn.'$DOMAIN':3478?transport=tcp" ]' > /etc/matrix-synapse/conf.d/turn_uris.yaml
RUN chown root /etc/matrix-synapse

USER matrix-synapse
RUN mkdir /var/lib/matrix-synapse/media
VOLUME "/var/lib/matrix-synapse/media"

ENTRYPOINT [ "/start" ]
