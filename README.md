# openclaw-chainguard

 * Runs [OpenClaw](https://openclaw.ai) in Docker using a [secure Chainguard base image](https://images.chainguard.dev/directory/image/node/versions)
 * The container runs as an unprivileged user (uid 65532)
 * OpenClaw only has access to the container filesystem and the configuration volume outside the container

The container entrypoint is the OpenClaw CLI. You can append subcommands and options directly.

## Prerequisites

Create a data directory for OpenClaw and set ownership to the container user:

```sh
mkdir -p /home/openclaw/.openclaw
chown 65532:65532 /home/openclaw/.openclaw
```

## Build

```sh
docker build -t openclaw:latest .
```

## Onboarding

```sh
docker run -it --rm -v /home/openclaw/.openclaw:/app/.openclaw --name openclaw openclaw:latest onboard --install-daemon
```

## Run the Gateway

Run the gateway in the foreground with verbose logging:

```sh
docker run -it --rm -v /home/openclaw/.openclaw:/app/.openclaw --name openclaw openclaw:latest gateway --port 18789 --verbose
```

Run the gateway in the background:

```sh
docker run -d --rm -v /home/openclaw/.openclaw:/app/.openclaw --name openclaw openclaw:latest gateway --port 18789
```
