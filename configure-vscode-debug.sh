#!/bin/bash

machine="`uname -s`"
case "$machine" in
  Linux*)  export SED_EXT=''   ;;
  Darwin*) export SED_EXT='.hydro-bk' ;;
  *)       export SED_EXT=''   ;;
esac

### Local Config ###
CONFIG_DIRECTORY='../config'
CONFIG_FILE=${CONFIG_DIRECTORY}'/hydroshare-config.yaml'

# This might be needed if the file has changed. 
# git checkout -- $CONFIG_FILE  # refresh this in case overridden otherwise

# Discover user and group under which this shell is running
HS_UID=`id -u`
HS_GID=`id -g`

# Set this user and group in hydroshare-config.yaml
sed -i 's/HS_SERVICE_UID:.*$/HS_SERVICE_UID: '$HS_UID'/' $CONFIG_DIRECTORY/hydroshare-config.yaml
sed -i 's/HS_SERVICE_GID:.*$/HS_SERVICE_GID: '$HS_GID'/' $CONFIG_DIRECTORY/hydroshare-config.yaml

# Read hydroshare-config.yaml into hydroshare-config.sh
# sed -e "s/:[^:\/\/]/=/g;s/$//g;s/ *=/=/g" ${CONFIG_FILE} | grep -v '^#' | grep -v ^$ > $CONFIG_DIRECTORY/hydroshare-config.sh

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

###############################################################################################################
### Preparing                                                                                            
###############################################################################################################

cp init-hydroshare-debug.template    init-hydroshare-debug

sed -i $SED_EXT s/HS_SERVICE_UID/$HS_SERVICE_UID/g init-hydroshare-debug
sed -i $SED_EXT s/HS_SERVICE_GID/$HS_SERVICE_GID/g init-hydroshare-debug

sed -i $SED_EXT s/HS_SSH_SERVER//g init-hydroshare-debug
sed -i $SED_EXT 's!HS_DJANGO_SERVER!'"python /tmp/debugpy --listen 0.0.0.0:5678 manage.py runserver 0.0.0.0:8000"'!g' init-hydroshare-debug                  

echo
echo '########################################################################################################################'
echo -e " All done, run `green '\"docker-compose -p hydroshare -f .vscode/docker-compose.debug.yml up\"'` to start HydroShare"
echo '########################################################################################################################'
echo

