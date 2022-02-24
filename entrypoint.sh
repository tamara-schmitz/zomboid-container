#!/bin/sh
set -xeu

echo "Update server"
nice -n19 steamcmd \
   +force_install_dir "${GAME_FOLDER}" \
   +login anonymous \
   +app_update ${STEAM_GAME} validate \
   +quit

if [ ${JAVA_USE_NATIVE} == "true" ]; then
    echo "Replace bunlded Java with upstream Java"
    rm -rf "${GAME_FOLDER}/jre64"
    ln -s /usr/lib64/jvm/jre "${GAME_FOLDER}/jre64"
fi

if [ -f "${GAME_FOLDER}/Zomboid/Server/${SERVER_NAME}.ini" ]; then
    echo "Turn off UPnP"
    sed -i "s/UPnP=true/UPnP=false/" "${GAME_FOLDER}/Zomboid/Server/${SERVER_NAME}.ini"
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
