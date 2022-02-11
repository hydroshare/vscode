# vscode hydroshare debug

Git Submodule for vscode debug of Hydroshare Docker containers

## Instructions to use
1. You must first clone [Hydroshare](https://github.com/hydroshare/hydroshare)
1. When you do, it will create an empty .vscode/ directory in the root of the hydroshare project
1. From your project root: `git submodule update --remote .vscode` (or if you have a version of Hydroshare without a `.gitmodules` file, then instead you can run: `git submodule add -f git@github.com:hydroshare/vscode.git .vscode`)
4. run `.vscode/configure-vscode-debug.sh` with "c" option to remove existing containers if you have them
5. run `docker-compose -p hydroshare -f .vscode/docker-compose.debug.yml up` to build containers
6. use vscode "run and debug" module to connect to the container and start debugging
7. Add breakpoints in vs-code
8. Browser-> navigate to localhost:8000 and trigger your breakpoints
