# Zomboid Container Image

This a container image that downloads, installs and updates a **Project
Zomboid** dedicated server.

The image is compatible with container runtimes such as Docker and Podman.

This image is using the [openSUSE Tumbleweed base
image](https://registry.opensuse.org). Base OS updates trigger container updates.

## Usage

Run the following everytime you want to launch the server

For Docker:

```sh
docker pull ghcr.io/tamara-schmitz/zomboid-container
docker run -d --rm --name zomboid \
    -p 16261/udp -p 8766/udp \
    -v /the/folder/where/you/want/to/put/the/game:/game \
    -e SERVER_NAME "myserver" \
    -e ADMIN_PASSWORD "badpassword"
```

For Podman:

```sh
podman pull ghcr.io/tamara-schmitz/zomboid-container
podman run -d --rm --name zomboid \
    -p 16261/udp -p 8766/udp \
    -v /the/folder/where/you/want/to/put/the/game:/game \
    -e SERVER_NAME "myserver" \
    -e ADMIN_PASSWORD "badpassword"
```

There are other options that you can use as well.

| Option and its default | What it does |
| - | - |
| `-e SERVER_NAME "tumbleserver"` | Set the server name |
| `-e ADMIN_PASSWORD "badlol"` | Set the administrator password |
| `-e PORT_GAME 16261` | Change the port that your game runs on |
| `-e PORT_STEAM 8766` | Change the port that Steam uses for its communication |
| `-e STEAMVAC "true"` | Deactivate Steam's Anti-cheat if you want with this |
| `-e MEMORY_HEAP_MIN "2g"` | Sets the Java Heap size. Basically `-Xms 2g` |
| `-e MEMORY_HEAP_MAX "2g"` | Sets the Java Heap size. Basically `-Xmx 2g` |
