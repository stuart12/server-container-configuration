FROM stuart/debian-sid:2018.03.31
MAINTAINER Stuart Pook
EXPOSE 8448
ENV DOMAIN=pook.it
ARG DATABASE_PASSWORD
ARG TURN_SECRET

RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends matrix-synapse
RUN apt-get --purge -q -y --allow-remove-essential remove login mount bash e2fsprogs fdisk
RUN apt-get clean

COPY synapse /etc/matrix-synapse/conf.d
RUN echo 'server_name: "'$DOMAIN'"' > /etc/matrix-synapse/conf.d/server.yaml
RUN (echo -n 'macaroon_secret_key: "'; tr -dc '[#-~!]' < /dev/urandom | dd status=none bs=50 count=1; echo '"') > /etc/matrix-synapse/conf.d/macaroon.yaml
RUN (echo -n 'registration_shared_secret: "'; tr -dc '[#-~!]' < /dev/urandom | dd status=none bs=6 count=7; echo '"') > /etc/matrix-synapse/conf.d/registration.yaml
RUN echo 'turn_shared_secret: "'"$TURN_SECRET"'"' > /etc/matrix-synapse/conf.d/turn_secret.yaml
RUN echo 'turn_uris: ["turn:turn.'$DOMAIN':3478?transport=udp", "turn:turn.'$DOMAIN':3478?transport=tcp" ]' > /etc/matrix-synapse/conf.d/turn_uris.yaml
RUN echo '    password: "'"$DATABASE_PASSWORD"'"' >>  /etc/matrix-synapse/conf.d/database.yaml
# need the signing key!
