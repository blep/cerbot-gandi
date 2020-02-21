#!/usr/bin/env sh
set -ex
echo Copying /config/gandi.ini to /app/gandi.ini
cp -p /config/gandi.ini /app/gandi.ini
echo Fixing access right of /app/gandi.ini
chmod 600 /app/gandi.ini
echo Running certbot "$@"
certbot "$@"
