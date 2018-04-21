#!/bin/sh -ex
# nginx requires dovecot to have a fixed IP address
# dovecot request the proxy to have fixed address
docker network create --ip-range 192.168.42.255/25 --subnet 192.168.42.0/24 proxy
