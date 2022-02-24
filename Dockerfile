FROM registry.opensuse.org/opensuse/openjdk:15

ENV GAME_FOLDER "/game"
ENV SAVE_FOLDER "/save"
ENV STEAM_GAME "380870"
ENV PORT_GAME 16261
ENV PORT_STEAM 8766
ENV SERVER_NAME "tumbleserver"
ENV ADMIN_PASSWORD "badlol"
ENV STEAMVAC "true"
ENV MEMORY_HEAP_MIN "2g"
ENV MEMORY_HEAP_MAX "2g"
ENV JAVA_EXTRA_ARGS "-XX:+ExplicitGCInvokesConcurrent \
        -XX:+AlwaysPreTouch \
        -XX:+UseThreadPriorities"
ENV JAVA_USE_NATIVE "false"

RUN zypper --non-interactive install --auto-agree-with-licenses \
        steamcmd

EXPOSE ${PORT_GAME}/udp
EXPOSE ${PORT_STEAM}/udp

WORKDIR ${GAME_FOLDER}

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
