#!/bin/bash
set -xeuo

echo "Update server"
nice -n19 steamcmd \
   +force_install_dir "${GAME_FOLDER}" \
   +login anonymous \
   +app_update ${STEAM_GAME} validate \
   +quit

if [ -f "${SAVE_FOLDER}/Zomboid/Server/${SERVER_NAME}.ini" ]; then
    echo "Turning off UPnP"
    sed -i "s/UPnP=true/UPnP=false/" "${SAVE_FOLDER}/Zomboid/Server/${SERVER_NAME}.ini"
    echo "Applying configuration from ENV"
    sed -i "s/DefaultPort=[0-9]+/DefaultPort=${PORT_GAME1}/" "${SAVE_FOLDER}/Zomboid/Server/${SERVER_NAME}.ini"
    sed -i "s/UDPPort=[0-9]+/UDPPort=${PORT_GAME2}/" "${SAVE_FOLDER}/Zomboid/Server/${SERVER_NAME}.ini"
    if [ -n "${STEAMVAC}" ]; then
        sed -i "s/SteamVAC=.+/SteamVAC=${STEAMVAC}/" "${SAVE_FOLDER}/Zomboid/Server/${SERVER_NAME}.ini"
    fi
    if [ -n "${PASSWORD}" ]; then
        sed -i "s/Password=.+/Password=${PASSWORD}/" "${SAVE_FOLDER}/Zomboid/Server/${SERVER_NAME}.ini"
    fi
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
    -port ${PORT_GAME1} \
    $@
