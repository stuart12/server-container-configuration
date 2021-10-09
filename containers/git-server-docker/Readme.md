# Git Server

## cut and paste a ssh-key (in a new file)

    docker stop git-server
    docker run   --mount type=volume,source=git-server-keys,destination=/git-server/keys -it --rm bash:4.4
    docker start git-server

## add a repo
    git init --bare $NEW_REPO_NAME
    docker run   --mount type=volume,source=git-server-repos,destination=/git-server/repos --mount type=bind,source=$PWD,dst=/foo -it --rm bash:4.4
        cp -a /foo/$NEW_REPO_NAME /git-server/repos/stuart/$NEW_REPO_NAME.git
        chown -Rc 1000:1000 /git-server/repos/stuart/$NEW_REPO_NAME.git

    origin ssh://git@hh:2222/git-server/repos/stuart/$NEW_REPO_NAME

## start the server
    docker run -d -p 2222:22   --restart unless-stopped --name git-server --detach --mount type=volume,source=git-server-keys,destination=/git-server/keys --mount type=volume,source=git-server-repos,destination=/git-server/repos jkarlos/git-server-docker
