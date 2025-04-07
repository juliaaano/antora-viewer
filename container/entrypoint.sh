#!/bin/sh

set -e

CONFIG_FILE=${ANTORA_CONFIG:-default-site.yml}

antora generate --to-dir=www ${CONFIG_FILE} --stacktrace

exec "$@"
