# hints for coturn on CoseOS

## Coturn

[coturn](https://github.com/coturn/coturn)

[How to enable VoIP relaying on your Home Server with TURN](https://github.com/matrix-org/synapse/blob/master/docs/turn-howto.rst)


	docker build --tag i-coturn . && sh ./start

     docker ps --size

shows 69.63 kB (virtual 9.188 MB)

## remarks

turnserver.conf just contains static-auth-secret=????
the same secret must be in your matrix-synapse configuration

## get the external_IP dynamically?

[anastasiia-zolochevska](https://github.com/anastasiia-zolochevska/turn-server-docker-image/blob/master/deploy-turnserver.sh)

    externalIp="$(dig +short myip.opendns.com @resolver1.opendns.com)"

[icanhazip.com FAQ](https://major.io/icanhazip-com-faq/icanhazip.com)

[synctree/docker-coturn](https://github.com/synctree/docker-coturn/blob/master/turnserver.sh)
    curl http://icanhazip.com

## Alpine or phusion/baseimage-docker

[Alphine](https://alpinelinux.org/) [Alpine docker image](https://hub.docker.com/_/alpine/) 
[Alpjine packages](https://pkgs.alpinelinux.org/packages?name=coturn&branch=&repo=&arch=&maintainer=)
[phusion/baseimage-docker](https://github.com/phusion/baseimage-docker)

## log rotation?

[set sane DOCKER_OPTS values for log rotation](https://github.com/coreos/coreos-kubernetes/issues/821)

[modules/aws: limit docker log file sizes](https://github.com/coreos/tectonic-installer/pull/244)

## coturn behind nginx proxy

[no](https://github.com/coturn/coturn/issues/43)
