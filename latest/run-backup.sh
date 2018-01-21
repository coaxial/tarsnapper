#!/usr/bin/env sh

/check-tarsnap-cache.sh &&\
tarsnapper -c /etc/tarsnapper.conf make
