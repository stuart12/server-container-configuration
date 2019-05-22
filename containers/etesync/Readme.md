# Hints
## see contents
	docker run --mount type=volume,source=etesync-db,destination=/mnt etesync -c "ls -la /mnt /etesync"
## join container
	docker exec --tty --interactive --user root etesync /bin/bash
## start with shell
	docker run --rm -it --network proxy --name etesync --cap-drop=all --mount type=volume,source=etesync-db,destination=/db etesync -xc /bin/sh
# bookmarks
[etesync/server-skeleton](https://github.com/etesync/server-skeleton)
[ETESync Docker Images](https://github.com/victor-rds/docker-etesync)
