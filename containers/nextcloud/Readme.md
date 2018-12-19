# Hints for Nextcloud
## restart
	docker update --restart unless-stopped nextcloud

# FIXME

redirect /var/www/html/data/nextcloud.log to /dev/stderr to avoidn filling the whole machine
## connect to container
	docker exec --tty  -i nextcloud bash
## get current version
	docker exec --user www-data nextcloud php occ --version
