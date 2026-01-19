#!/bin/bash

CONFIG_FILE=${ANTORA_CONFIG:-default-site.yml}
USER_DATA_FILE=${ANTORA_USER_DATA:-user_data.yml}
TEMP_CONFIG_FILE=".tmp_${CONFIG_FILE}"
    
if [[ -f "$USER_DATA_FILE" ]]; then
    echo "Merging user data from ${USER_DATA_FILE} into Antora config..."
    cp -f "${CONFIG_FILE}" "$TEMP_CONFIG_FILE"
    yq -i ".asciidoc.attributes *= load(\"${USER_DATA_FILE}\")" "$TEMP_CONFIG_FILE"
    CONFIG_FILE="$TEMP_CONFIG_FILE"
fi

printf "\nBuilding Antora site...\n\n"

antora generate --to-dir=www ${CONFIG_FILE} --stacktrace

printf "\nBuild completed at %s\n\n" "$(date)"