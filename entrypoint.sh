#!/bin/sh
set -xeuo

echo "Update server"
nice -n19 steamcmd \
   +force_install_dir "${GAME_FOLDER}" \
   +login anonymous \
   +app_update ${STEAM_GAME} validate \
   +quit

if [ -f "${SAVE_FOLDER}/Server/${SERVER_NAME}.ini" ]; then
    echo "Turn off UPnP"
    sed -i "s/UPnP=true/UPnP=false/" "${SAVE_FOLDER}/Server/${SERVER_NAME}.ini"
fi

echo "Start server"
./start-server.sh \
    -Xms${MEMORY_HEAP_MIN} \
    -Xmx${MEMORY_HEAP_MAX} \
    -Duser.home="${SAVE_FOLDER}" \
    ${JAVA_EXTRA_ARGS} \
    -- \
    -servername ${SERVER_NAME} \
    -adminpassword ${ADMIN_PASSWORD} \
    -steamvac ${STEAMVAC} \
    -port ${PORT_GAME} \
    -steamport1 ${PORT_STEAM} \
    $@
