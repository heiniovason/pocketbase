# README 

The sole purpose of this repo is to maintain, build and release a custom PocketBase image.

This means that **compose.yml is for local development and integration testing only**. It spins up an environment including Mailpit for SMTP testing and Caddy for reverse-proxy simulation.

To ensure the **Pocketbase** application container is ready for use immediately upon startup the `entrypoint.sh` bootstraps it with a superuser and directory structure on every boot.

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
