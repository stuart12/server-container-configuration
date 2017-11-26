# Dovecot Hints

[Dovecot](https://www.dovecot.org/)

## nginx mail module

[The nginx mail module: a primer](https://github.com/robn/nginx-xmpp)

nginx mail module job is to act as an IMAP, POP3 and SMTP server, accepting connections and proxying them through to "real" IMAP/POP3/SMTP servers on the backend.

nginx itself speaks just enough of these protocols to do the initial greeting and auth handshake. Once auth is completed, nginx calls out to an external auth service to validate the credentials. The auth service returns a yes/no response and, if the auth succeeds, an IP, username, password, etc for the backend server.

nginx then connects to the backend service, authenticates on behalf of the user using the credentials supplied by the auth service and, once completed, returns an "auth success" message to the client. All data in both directions is then proxied by nginx's normal connection proxying machinery.

[allow Dovecot as an authentication service](https://workaround.org/ispmail/jessie/setting-up-dovecot)

    # Postfix smtp-auth
    unix_listener /var/spool/postfix/private/auth {
      mode = 0660
      user = postfix
      group = postfix
    }

[Dovecot Authentication Protocol v1.1](https://wiki1.dovecot.org/Authentication%20Protocol)

[sending](https://github.com/bmanojlovic/mod_authn_dovecot/blob/master/mod_authn_dovecot.c)
    echo  -en '\0stuart\0???????' |base64
    AUTH	3	PLAIN	service=IMAP	secured	resp=67N4wdd3s78i99kiiuu08utuopk=

    OK	3	user=stuart	

[Searching for auth_http](https://www.nginx.com/resources/wiki/search/?q=auth_http)

finally, [simple passthrough](https://serverfault.com/questions/594962/nginx-understanding-the-purpose-of-auth-http-imap-proxy)

Do i have to write php? [Using a PHP Script on an Apache Server as the IMAP Auth Backend](https://www.nginx.com/resources/wiki/start/topics/examples/imapauthenticatewithapachephpscript/)

# connecting networks

[How to reach a container from another container without IP of dockerNAT?](https://forums.docker.com/t/how-to-reach-a-container-from-another-container-without-ip-of-dockernat/21083/4)
    docker network create mynet
    docker run --name foo --net mynet img
    docker run --name bar --net mynet img
You will be able to reach foo and bar from each other using DNS entries corresponding to the container name, e.g. curl foo should work from bar if you're serving something on port 80

## via sockets?
[Use Unix sockets with Docker](https://www.jujens.eu/posts/en/2017/Feb/15/docker-unix-socket/)
