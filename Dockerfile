FROM registry.opensuse.org/opensuse/tumbleweed

ENV GAME_FOLDER "/game"
ENV SAVE_FOLDER "/save"
ENV STEAM_GAME "380870"
ENV PORT_GAME1 16261
ENV PORT_GAME2 16262
ENV PORT_STEAM 8766
ENV SERVER_NAME "tumbleserver"
ENV ADMIN_PASSWORD "badlol"
ENV STEAMVAC "true"
ENV MEMORY_HEAP_MIN "4g"
ENV MEMORY_HEAP_MAX "4g"
ENV JAVA_EXTRA_ARGS "-XX:+ExplicitGCInvokesConcurrent \
        -XX:+AlwaysPreTouch \
        -XX:+UseThreadPriorities"

RUN zypper --non-interactive install --auto-agree-with-licenses \
        steamcmd

EXPOSE ${PORT_GAME1}/udp
EXPOSE ${PORT_GAME2}/udp
EXPOSE ${PORT_STEAM}/udp

WORKDIR ${GAME_FOLDER}

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
