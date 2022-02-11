# .vscode

Git Submodule for vscode debug of Hydroshare Docker containers

## Instructions to use
1. You must first clone [Hydroshare](https://github.com/hydroshare/hydroshare)
1. When you do, it will create an empty .vscode/ directory in the root of the hydroshare project
1. cd into .vscode and `git pull`
1. run `local-dev-first-start-only.sh` with "c" option to remove existing containers if you have them
2. run `docker-compose -p hydroshare -f .vscode/docker-compose.debug.yml up` to build containers
2. use vscode "run and debug" module to connect to the container and start debugging
3. Add breakpoints in vs-code
4. Browser-> navigate to localhost:8000 and trigger your breakpoints
