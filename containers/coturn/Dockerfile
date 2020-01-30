# A docker image for https://github.com/coturn/coturn
# You must change EXTERNAL_IP
# turnserver.conf just contains static-auth-secret=????
# the same secret must be in your matrix-synapse configuration
FROM alpine:latest
LABEL version="1.0"
MAINTAINER Stuart Pook

ENV CONFIG /etc/coturn.conf
ADD turnserver.conf $CONFIG
ENV EXTERNAL_IP 31.220.4.198
ENV MIN_PORT 49152
ENV MAX_PORT 49352
ENV LISTENING_PORT 3478
RUN apk update
RUN apk add --no-cache coturn
# https://github.com/matrix-org/synapse/blob/master/docs/turn-howto.rst
ENTRYPOINT exec turnserver -c $CONFIG \
	--userdb /tmp/turndb \
	--external-ip $EXTERNAL_IP \
	--min-port $MIN_PORT \
	--max-port $MAX_PORT \
	--listening-port $LISTENING_PORT \
	--realm turn.pook.it \
	--total-quota=128 \
	--verbose \
	--use-auth-secret \
	--no-tcp-relay \
	--no-cli \
	--no-stdout-log \
	--log-file -

# --denied-peer-ip=192.168.0.0-192.168.255.255
# --denied-peer-ip=172.16.0.0-172.31.255.255
# --denied-peer-ip=10.0.0.0-10.255.255.255
EXPOSE $LISTENING_PORT
EXPOSE $LISTENING_PORT/udp
EXPOSE $MIN_PORT:$MAX_PORT/udp
EXPOSE $MIN_PORT:$MAX_PORT
USER turnserver
