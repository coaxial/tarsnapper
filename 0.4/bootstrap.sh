#!/usr/bin/env sh

# Do this at runtime so that the env var is evaluated with the values from any
# docker-compose or docker run command line arguments. If run from the
# Dockerfile, it will use env vars as they're defined when building the image.
BACKUP_PERIODICITY=${BACKUP_PERIODICITY:-"* * * * 7"}

# using a separate cron file and overwriting it to avoid adding multiple
# entries every time the container starts
echo "${BACKUP_PERIODICITY} /check-tarsnap-cache.sh && tarsnapper -c /etc/tarsnapper.conf make 2>&1 /var/log/tarsnapper-cron.log" > /etc/cron.d/tarsnapper/root

crond -f -c /etc/cron.d/tarsnapper && tail -f /var/log/tarsnapper-cron.log
