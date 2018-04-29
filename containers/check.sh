#!/bin/sh
check(){
    h=$1
    p=${2-https}
    s=${3+-starttls $3}
    echo | openssl s_client -servername $h.pook.it -connect $h.pook.it:$p $s 2>/dev/null | openssl x509 -noout -dates | sed -e "s/^/$1: /"
}
check nextcloud
check hh
check ffsync
check smtp3 submission smtp
check imap3 imap imap

# use https://github.com/ahaw021/SSL-MAIL-PROTOCOLS-TESTING ?
