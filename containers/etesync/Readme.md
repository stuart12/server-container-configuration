# Hints
## create admin user
	docker exec --tty --interactive etesync /bin/python3 /etesync/manage.py createsuperuser
## see contents
	docker run --mount type=volume,source=etesync-v2-db,destination=/mnt etesync -c "ls -la /mnt /etesync"
## join container
	docker exec --tty --interactive --user root etesync /bin/sh
	docker exec --tty --interactive etesync /bin/sh
## start with shell
	docker run --rm -it --network proxy --name etesync --cap-drop=all --mount type=volume,source=etesync-v2-db,destination=/db etesync -xc /bin/sh
# bookmarks
[etesync/server-skeleton](https://github.com/etesync/server-skeleton)
[ETESync Docker Images](https://github.com/victor-rds/docker-etesync)
## git server code SHA1 hash
	docker exec etesync cat /etesync/git-HEAD.txt
