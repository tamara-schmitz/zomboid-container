# Zomboid Container Image

This a container image that downloads, installs and updates a **Project
Zomboid** dedicated server.

The image is compatible with container runtimes such as Docker and Podman.

This image is using the [openSUSE Tumbleweed base
image](https://registry.opensuse.org). Base OS updates trigger container updates.

## Usage

Copy these command blocks below and **adjust them** to your needs.
You can run them everytime you want to launch the server.

For Docker:

```sh
docker run -d --rm --name zomboid --pull newer \
    -p 16261:16261/udp -p 16262:16262/udp -p 8766:8766/udp \
    -v /path/of/game:/game \
    -v /path/of/savefiles:/save \
    -e SERVER_NAME="myserver" \
    -e ADMIN_PASSWORD="badpassword" \
    ghcr.io/tamara-schmitz/zomboid-container
```

For Podman:

```sh
podman run -d --rm --name zomboid --pull newer \
    -p 16261:16261/udp -p 16262:16262/udp -p 8766:8766/udp \
    -v /path/of/game:/game \
    -v /path/of/savefiles:/save \
    -e SERVER_NAME="myserver" \
    -e ADMIN_PASSWORD="badpassword" \
    ghcr.io/tamara-schmitz/zomboid-container
```

There are other options that you can use as well. Please note that due to
limitations some of these are only applied the second time you launch a
server if you start with a blank save folder.

| Option and its default | What it does |
| - | - |
| `-e SERVER_NAME="servertest"` | Set the server name. This also determins the naming of your config files. |
| `-e PASSWORD=""` | Can enable password protection on the server. Every user
has to enter the server password you specify here. |
| `-e ADMIN_PASSWORD="badlol"` | Set the administrator password |
| `-e PORT_GAME1=16261` | Change the port that your game runs on. This has to match the port that you publish using `-p 16261:16261/udp`. |
| `-e PORT_GAME2=16262` | Change the port that your game runs on. This has to match the port that you publish using `-p 16262:16262/udp`. |
| `-e STEAMVAC=""` | Enable or disable Steam's Anti-cheat by setting this to either `true` or `false`. |
| `-e MEMORY_HEAP_MIN="4g"` | Sets the Java Heap size. Like `-Xms 4g` |
| `-e MEMORY_HEAP_MAX="4g"` | Sets the Java Heap size. Like `-Xmx 4g` |
| `-e JAVA_EXTRA_ARGS="-XX:+ExplicitGCInvokesConcurrent -XX:+AlwaysPreTouch -XX:+UseThreadPriorities"` | Here you can add extra arguments to be passed to JVM. |
