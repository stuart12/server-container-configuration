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
	--external-ip $EXTERNAL_IP \
	--min-port $MIN_PORT \
	--max-port $MAX_PORT \
	--listening-port $LISTENING_PORT \
	--realm turn.pook.it \
	--verbose \
	--lt-cred-mech \
	--use-auth-secret \
	--no-tcp-relay \
	--denied-peer-ip=10.0.0.0-10.255.255.255 \
	--no-cli \
	--log-file -

EXPOSE $LISTENING_PORT
EXPOSE $LISTENING_PORT/udp
EXPOSE $MIN_PORT:$MAX_PORT/udp
