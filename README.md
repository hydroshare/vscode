# vscode hydroshare debug

Repo for vscode debug of Hydroshare Docker containers

## Instructions to use
1. You must first clone [Hydroshare](https://github.com/hydroshare/hydroshare) if you haven't
2. Run [local-dev-first-start-only](https://github.com/hydroshare/hydroshare/blob/develop/local-dev-first-start-only.sh) if you haven't. No need to do the `docker-compose up`, we will modify that step so that it uses a custom .yml file
3. cd into your new hydroshare dir and clone this repo: `git clone git@github.com:hydroshare/vscode.git .vscode`
4. run `.vscode/configure-vscode-debug.sh` to create a required init-hydroshare-debug and remove your hydroshare container
6. run `docker-compose -p hydroshare -f .vscode/docker-compose.debug.yml up` to build the new container and bring it up
7. use vscode "run and debug" module to connect to the container and start debugging![image](https://user-images.githubusercontent.com/17934193/208769548-051c49d0-52e1-40f6-968b-ca863a1b385f.png)

9. Add breakpoints in vs-code
10. Browser-> navigate to localhost:8000 and trigger your breakpoints

## submodule
You can run this as a git submodule too but I don't think we want to checkin any of the submodule info into the hydroshare repo

So if you do this, just make sure you don't commit the added files to [Hydroshare](https://github.com/hydroshare/hydroshare)

From your project root:
- `git submodule add -f git@github.com:hydroshare/vscode.git .vscode`
- `git submodule update --remote .vscode`
- then follow all of the above instructions to use
