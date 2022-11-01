# Zomboid Container Image

This a container image that downloads, installs and updates a **Project
Zomboid** dedicated server.

The image is compatible with container runtimes such as Docker and Podman.

This image is using the [openSUSE Tumbleweed base
image](https://registry.opensuse.org). Base OS updates trigger container updates.

## Usage

Copy these command blocks below and adjust them to your needs.
You can run them everytime you want to launch the server.

For Docker:

```sh
docker pull ghcr.io/tamara-schmitz/zomboid-container && \
docker run -d --rm --name zomboid \
    -p 16261:16261/udp -p 8766:8766/udp \
    -v /path/of/game:/game \
    -v /path/of/savefiles:/save \
    -e SERVER_NAME="myserver" \
    -e ADMIN_PASSWORD="badpassword" \
    ghcr.io/tamara-schmitz/zomboid-container
```

For Podman:

```sh
podman pull ghcr.io/tamara-schmitz/zomboid-container && \
podman run -d --rm --name zomboid \
    -p 16261:16261/udp -p 8766:8766/udp \
    -v /path/of/game:/game \
    -v /path/of/savefiles:/save \
    -e SERVER_NAME="myserver" \
    -e ADMIN_PASSWORD="badpassword" \
    ghcr.io/tamara-schmitz/zomboid-container
```

There are other options that you can use as well.

| Option and its default | What it does |
| - | - |
| `-e SERVER_NAME="tumbleserver"` | Set the server name |
| `-e ADMIN_PASSWORD="badlol"` | Set the administrator password |
| `-e PORT_GAME=16261` | Change the port that your game runs on. This has to match the port that you publish using `-p 16261:16261/udp`. |
| `-e PORT_STEAM=8766` | Change the port that Steam uses for its communication. This has to match the port that you publish using `-p 8766:8766/udp`.|
| `-e STEAMVAC="true"` | Deactivate Steam's Anti-cheat if you want with this |
| `-e MEMORY_HEAP_MIN="4g"` | Sets the Java Heap size. Basically `-Xms 4g` |
| `-e MEMORY_HEAP_MAX="4g"` | Sets the Java Heap size. Basically `-Xmx 4g` |
| `-e JAVA_EXTRA_ARGS="-XX:+ExplicitGCInvokesConcurrent -XX:+AlwaysPreTouch -XX:+UseThreadPriorities"` | Here you can add extra arguments to be passed to JVM. |
