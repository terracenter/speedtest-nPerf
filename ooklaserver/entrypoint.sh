#!/bin/sh
set -e

SERVER_PROPERTIES_FILE="OoklaServer.properties"
DEFAULT_SERVER_PROPERTIES_FILE="OoklaServer.properties.default"

# Copy properties file to binary directory so that changes are not made to the original file
# while ensuring that settings are correct for the container
if [ -f "data/$PROPERTIES_FILE" ]; then
    cp -f "data/$PROPERTIES_FILE" "$SERVER_PROPERTIES_FILE"
else
    cp -f "$DEFAULT_SERVER_PROPERTIES_FILE" "$SERVER_PROPERTIES_FILE"
fi

# Output information about the container
echo "OoklaServer Container IP address: $(awk 'END{print $1}' /etc/hosts)"
echo "OoklaServer Version: " $(./OoklaServer --version)
echo "OoklaServer Running as User: $(whoami)"
echo "OoklaServer configuration file: $PROPERTIES_FILE"

exec "$@"
