#!/bin/sh
set -xeuo

# Remove Java Native Symlink
if [ -L "${GAME_FOLDER}/jre64" ]; then
    rm "${GAME_FOLDER}/jre64"
fi

echo "Update server"
nice -n19 steamcmd \
   +force_install_dir "${GAME_FOLDER}" \
   +login anonymous \
   +app_update ${STEAM_GAME} validate \
   +quit

# Replace bunlded Java with upstream Java
if [ ${JAVA_USE_NATIVE} == "true" ]; then
    rm -rf "${GAME_FOLDER}/jre64"
    ln -s /usr/lib64/jvm/jre "${GAME_FOLDER}/jre64"
fi

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
