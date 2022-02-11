#!/bin/bash

machine="`uname -s`"
case "$machine" in
  Linux*)  export SED_EXT=''   ;;
  Darwin*) export SED_EXT='.hydro-bk' ;;
  *)       export SED_EXT=''   ;;
esac

### Local Config ###
CONFIG_DIRECTORY='./config'
CONFIG_FILE=${CONFIG_DIRECTORY}'/hydroshare-config.yaml'

# This might be needed if the file has changed. 
# git checkout -- $CONFIG_FILE  # refresh this in case overridden otherwise

# Discover user and group under which this shell is running
HS_UID=`id -u`
HS_GID=`id -g`

# import hydroshare-config.sh into working environment
while read line; do export $line; done < <(cat ${CONFIG_DIRECTORY}/hydroshare-config.sh)

### Add color scheme to text | result output
function green() {
    local TEXT
    if [ "$1" == "" ]; then
        TEXT=Done
    else
        TEXT="$1"
    fi
    echo -n "\x1B[1;32m${TEXT}\x1B[0m"
}

function red() {
    local TEXT
    if [ "$1" == "" ]; then
        TEXT=Failure
    else
        TEXT="$1"
    fi
    echo -n "\x1B[31m${TEXT}\x1B[0m"
}

### Clean-up | Setup hydroshare environment

REMOVE_CONTAINER=YES

echo '########################################################################################################################'
echo -e " `red 'REMOVING YOUR HYDROSHARE CONTAINER...'`"
echo '########################################################################################################################'


DOCKER_COMPOSER_YAML_FILE='.vscode/docker-compose.debug.yml'
# HYDROSHARE_CONTAINERS=(nginx hydroshare defaultworker data.local.org rabbitmq solr postgis users.local.org)
HYDROSHARE_CONTAINERS=(hydroshare)
echo "  Removing HydroShare container..."
for i in "${HYDROSHARE_CONTAINERS[@]}"; do
echo -e "    Removing $i container if existed..."
echo -e "     - docker rm -f `green $i`"
docker rm -f $i 2>/dev/null 1>&2
done

###############################################################################################################
### Preparing                                                                                            
###############################################################################################################

cp .vscode/init-hydroshare-debug.template    .vscode/init-hydroshare-debug

sed -i $SED_EXT s/HS_SERVICE_UID/$HS_SERVICE_UID/g .vscode/init-hydroshare-debug
sed -i $SED_EXT s/HS_SERVICE_GID/$HS_SERVICE_GID/g .vscode/init-hydroshare-debug

sed -i $SED_EXT s/HS_SSH_SERVER//g .vscode/init-hydroshare-debug
sed -i $SED_EXT 's!HS_DJANGO_SERVER!'"python /tmp/debugpy --listen 0.0.0.0:5678 manage.py runserver 0.0.0.0:8000"'!g' .vscode/init-hydroshare-debug                  

echo
echo '########################################################################################################################'
echo -e " All done, run `green '\"docker-compose -p hydroshare -f .vscode/docker-compose.debug.yml up\"'` to start HydroShare"
echo '########################################################################################################################'
echo

