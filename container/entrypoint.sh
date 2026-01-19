#!/bin/sh

set -e

CONFIG_FILE=${ANTORA_CONFIG:-default-site.yml}
USER_DATA_FILE=${ANTORA_USER_DATA:-user_data.yml}
TEMP_CONFIG_FILE=".tmp_${CONFIG_FILE}"

echo "Starting Antora Viewer in live reload mode..."

# Start http-server in the background
echo "Starting HTTP server on port 8080..."
npx http-server www -c-1 -p 8080 --cors &
HTTP_SERVER_PID=$!

# Function to cleanup background processes
cleanup() {
    echo "Shutting down..."
    kill $HTTP_SERVER_PID 2>/dev/null || true
    kill $NODEMON_PID 2>/dev/null || true
    if [[ -f "$USER_DATA_FILE" ]]; then
        rm -f "$TEMP_CONFIG_FILE"
    fi
    exit 0
}

# Set up signal handlers
trap cleanup TERM INT

# Start file watcher
echo "Watching for file changes..."
echo "Press Ctrl+C to stop"

# Watch for changes in common Antora source directories and root config files
# Watch common Antora directories and root for config files
nodemon --legacy-watch \
        --ext "adoc,yml,yaml" \
        --ignore "www" \
        --ignore ".cache" \
        --ignore "$TEMP_CONFIG_FILE" \
        --exec build_site.sh &
NODEMON_PID=$!

# Wait for signals
wait
