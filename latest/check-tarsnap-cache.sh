#!/usr/bin/env sh

# Only rebuilds the cache if the directory is empty. --fsck costs money because
# it's transferring data.
if [ -z "$(ls -A /usr/local/tarsnap-cache/)" ]; then
  tarsnap --fsck
fi
