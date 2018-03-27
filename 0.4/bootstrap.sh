#!/usr/bin/env sh

# Do this at runtime so that the env var is evaluated with the values from any
# docker-compose or docker run command line arguments. If run from the
# Dockerfile, it will use env vars as they're defined when building the image.
BACKUP_PERIODICITY=${BACKUP_PERIODICITY:-"* * * * 7"}

# using a separate cron file and overwriting it to avoid adding multiple
# entries every time the container starts
echo "${BACKUP_PERIODICITY}"' (echo "$(date)" && /check-tarsnap-cache.sh && tarsnapper -c /etc/tarsnapper.conf make; echo "-----")' > /etc/cron.d/tarsnapper/root
# check and repair tarsnap cache when starting the container to ensure
# consistent cache. this costs a bit of money because it transfers data from
# tarsnap servers but will only run when starting up the container; not with
# every backup
tarsnap --fsck &&\
echo "Done" &&\
echo "Starting crond" &&\
crond -c /etc/cron.d/tarsnapper &&\
echo "Done" &&\
tail -f /var/log/messages
