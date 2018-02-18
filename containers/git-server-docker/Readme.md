docker run   --mount type=volume,source=git-servekeys,destination=/git-server/keys -it --rm bash:4.4

docker run   --mount type=volume,source=git-server-repos,destination=/git-server/repos --mount type=bind,source=$PWD,dst=/foo -it --rm bash:4.4

docker run -d -p 2222:22   --restart unless-stopped --name git-server --detach --mount type=volume,source=git-server-keys,destination=/git-server/keys --mount type=volume,source=git-server-repos,destination=/git-server/repos jkarlos/git-server-docker
