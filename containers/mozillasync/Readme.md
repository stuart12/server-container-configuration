# Syncserver
## building the image
builing the image requires stopping all containers else the compile is killed by a lack of memory
## error logs in Firefox
about:sync-log
## database upgrade
[sqlite](https://github.com/mozilla-services/syncserver/pull/193#commitcomment-36884169)
[PostgreSQL](https://adol.pw/2020/04/12/fixing-firefox-sync-server/)
	ALTER TABLE users ADD keys_changed_at BIGINT;
	ALTER TABLE users ADD node VARCHAR(255);
## server
[Mozila Syncserver](https://github.com/mozilla-services/syncserver)
## Apache2
    <VirtualHost *:443>
	    DocumentRoot /var/www/html
	    ServerName iwsync.pook.it
	    CustomLog /var/log/apache2/iwsync.log combined
	    
            LogLevel notice

	    SSLEngine on
	    SSLCertificateFile  /etc/letsencrypt/live/self.pook.it/fullchain.pem
	    SSLCertificateKeyFile /etc/letsencrypt/live/self.pook.it/privkey.pem

	    WSGIDaemonProcess  sync user=sync15 group=sync15 processes=2 threads=25 python-path=/opt/syncserver/local/lib/python2.7/site-packages/
            WSGIScriptAlias /syncff/ /opt/syncserver/syncserver.wsgi/
            WSGIProcessGroup sync
            WSGIPassAuthorization On
	    <Directory /opt/syncserver>
		    Require all granted
	    </Directory>
    </VirtualHost>

## bash in container
	docker exec --interactive --tty mozillasync  /bin/bash
