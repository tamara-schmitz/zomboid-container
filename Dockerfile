FROM registry.opensuse.org/opensuse/tumbleweed

ENV GAME_FOLDER "/game"
ENV SAVE_FOLDER "/save"
ENV STEAM_GAME "380870"
ENV PORT_GAME1 16261
ENV PORT_GAME2 16262
ENV SERVER_NAME "servertest"
ENV PASSWORD ""
ENV ADMIN_PASSWORD "badlol"
ENV STEAMVAC ""
ENV MEMORY_HEAP_MIN "4g"
ENV MEMORY_HEAP_MAX "4g"
ENV JAVA_EXTRA_ARGS "-XX:+ExplicitGCInvokesConcurrent \
        -XX:+AlwaysPreTouch \
        -XX:+UseThreadPriorities"

ADD entrypoint.sh /

RUN zypper --non-interactive install --auto-agree-with-licenses \
        steamcmd

EXPOSE ${PORT_GAME1}/udp
EXPOSE ${PORT_GAME2}/udp
VOLUME ${GAME_FOLDER} ${SAVE_FOLDER}

WORKDIR ${GAME_FOLDER}

ENTRYPOINT ["/entrypoint.sh"]
