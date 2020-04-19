# A docker image for https://github.com/coturn/coturn
# You must change EXTERNAL_IP
# turnserver.conf just contains static-auth-secret=????
# the same secret must be in your matrix-synapse configuration
# https://github.com/matrix-org/synapse/blob/master/docs/turn-howto.md
FROM alpine:latest
RUN apk update
RUN apk add --no-cache coturn
MAINTAINER Stuart Pook

ARG relay_min
ARG relay_max
ARG stun_port
ARG public_ip

ENV CONFIG /etc/coturn.conf
COPY turnserver.conf $CONFIG
RUN chmod 644 $CONFIG
ENV EXTERNAL_IP=$public_ip
ENV MIN_PORT $relay_min
ENV MAX_PORT $relay_max
ENV LISTENING_PORT=$stun_port
# https://github.com/coturn/coturn/blob/master/examples/etc/turnserver.conf
ENTRYPOINT exec turnserver -c $CONFIG \
	--pidfile=/tmp/pidfile \
	--userdb=/tmp/turndb \
	--external-ip=$EXTERNAL_IP \
	--min-port=$MIN_PORT \
	--max-port=$MAX_PORT \
	--listening-port=$LISTENING_PORT \
	--realm=turn.pook.it \
	--user-quota=12 \
	--total-quota=128 \
	--verbose \
	--use-auth-secret \
	--no-tcp-relay \
	--no-multicast-peers \
	--no-cli \
	--log-file=stdout

	# --no-auth \
# --denied-peer-ip=192.168.0.0-192.168.255.255
# --denied-peer-ip=172.16.0.0-172.31.255.255
# --denied-peer-ip=10.0.0.0-10.255.255.255
EXPOSE $LISTENING_PORT
EXPOSE $LISTENING_PORT/udp
EXPOSE $MIN_PORT:$MAX_PORT/udp
EXPOSE $MIN_PORT:$MAX_PORT
USER turnserver
LABEL version="1.2"
