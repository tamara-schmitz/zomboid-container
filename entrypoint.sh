#!/bin/sh
set -xeu

echo "Update server"
steamcmd \
   +force_install_dir ${GAME_FOLDER} \
   +login anonymous \
   +app_update ${STEAM_GAME} validate \
   +quit

echo "Start server"
./start-server.sh \
    -servername ${SERVER_NAME} \
    -adminpassword ${ADMIN_PASSWORD} \
    -steamvac ${STEAMVAC} \
    -port ${PORT_GAME} \
    -steamport1 ${PORT_STEAM} \
    -Xms ${MEMORY_HEAP_MIN} \
    -Xms ${MEMORY_HEAP_MAX}
