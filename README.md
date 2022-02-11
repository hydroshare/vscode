# vscode hydroshare debug

Repo for vscode debug of Hydroshare Docker containers

## Instructions to use
1. You must first clone [Hydroshare](https://github.com/hydroshare/hydroshare)
2. cd into your new hydroshare dir and clone this repo: `git clone git@github.com:hydroshare/vscode.git .vscode`
4. run `.vscode/configure-vscode-debug.sh`
5. run `docker-compose -p hydroshare -f .vscode/docker-compose.debug.yml up` to build containers
6. use vscode "run and debug" module to connect to the container and start debugging
7. Add breakpoints in vs-code
8. Browser-> navigate to localhost:8000 and trigger your breakpoints

## submodule
You can run this as a git submodule too but I don't think we want to checkin any of the submodule info into the hydroshare repo
So if you do this, just make sure you don't commit the added files to [Hydroshare](https://github.com/hydroshare/hydroshare)
From your project root:
`git submodule add -f git@github.com:hydroshare/vscode.git .vscode`
`git submodule update --remote .vscode`
