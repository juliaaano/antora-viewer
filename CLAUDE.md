# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Antora Viewer is a container image that builds and serves Antora documentation sites with live reload. It is intended as a development tool: mount an Antora project directory into the container and it will generate the site, serve it on port 8080, and rebuild on file changes.

The container image is published to `ghcr.io/juliaaano/antora-viewer`.

## Repository Structure

All meaningful code lives in `container/`:

- `Containerfile` — Multi-arch image based on UBI9 Node.js 20. Installs `@antora/cli@3.1`, `@antora/site-generator@3.1`, `http-server`, `nodemon`, and `yq`.
- `entrypoint.sh` — Starts `http-server` (serves `www/` on port 8080) and `nodemon` (watches `.adoc`, `.yml`, `.yaml` files, ignores `www` and `.cache`, triggers `build_site.sh` on changes).
- `build_site.sh` — Optionally merges a user data YAML file into the Antora playbook using `yq`, then runs `antora generate`.

## Build and Run

```sh
# Build the container image
cd container/
podman build -t localhost/antora-viewer .

# Run against an Antora project directory
podman run --rm --name antora -v $PWD:/antora -p 8080:8080 -i -t localhost/antora-viewer
```

Runtime environment variables:
- `ANTORA_CONFIG` — Antora playbook filename (default: `default-site.yml`)
- `ANTORA_USER_DATA` — YAML file with extra Antora attributes to merge (default: `user_data.yml`)

## CI/CD

GitHub Actions workflow (`.github/workflows/cicd.yml`) builds multi-arch (`amd64`/`arm64`) images using Buildah and pushes to GHCR. Triggered on pushes to `main` or version tags (`v*`) when `container/**` or the workflow file changes.
