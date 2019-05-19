# Syncserver
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

