#!/usr/bin/env sh
set -e
echo Writing GANDI_API_KEY environment variable to /app/gandi.ini
echo certbot_plugin_gandi:dns_api_key=$GANDI_API_KEY > /app/gandi.ini
chmod 600 /app/gandi.ini
echo Running certbot "$@"
certbot "$@"
