# README 

The sole purpose of this repo is to maintain, build and release a custom PocketBase image.

This means that **compose.yml is for local development and integration testing only**. It spins up an environment including Mailpit for SMTP testing and Caddy for reverse-proxy simulation.

To ensure the Pocketbase application container is ready for use immediately, entrypoint.sh creates a superuser on first boot and writes pb_data/.superuser_created to prevent the upsert from running on subsequent restarts. Deleting this file will recreate the superuser on next boot, overwriting any password changes made since.

A built-in healthcheck in the Dockerfile monitors the **Pocketbase** `/api/health` endpoint. This makes the image "orchestrator-aware", allowing tools like Docker Swarm or Kubernetes to automatically detect hangs and restart the service to maintain uptime.

## Quick Start (Development)

**Developer shortcuts:** See Makefile.

Copy `dev-environment/pb.env.example` to `dev-environment/pb.env`. 
For convenience default values are set in both files, but do check them out.

To verify the full integration (Proxy, Mail-trap, and Backend), simply run: 

`make b` (*docker compose up --build --detach*)

Check (Pocketbase) backend container health run:

`make h` (*You need to install `jq` in order for this command to work*)

To see logs run:

`make l` (*docker compose logs --follow*)

Pocketbase index: https://pb.dev.localhost

Pocketbase admin login: https://pb.dev.localhost/_/

Mailpit UI: http://localhost:8025

## Architecture

The image is published as a multi-arch manifest supporting `linux/amd64` and `linux/arm64`, so it runs natively on both x86-64 servers and ARM-based hosts (AWS Graviton, Apple Silicon).

To build locally for a specific architecture:

```bash
docker buildx build --platform linux/arm64 -t pocketbase:local .
```

## Hooks

`pb_hooks/` is empty in this image. To use hooks in a derived image, COPY them in your own Dockerfile:

```dockerfile
FROM heiniovason/pocketbase:1.0.0
COPY pb_hooks/ /pb/pb_hooks/
```

In development, hooks are mounted via the bind mount defined in `compose.yml`.
