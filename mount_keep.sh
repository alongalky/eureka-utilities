#!/bin/bash
tags=$(curl -s -H Metadata-Flavor:Google http://metadata/computeMetadata/v1/instance/tags)
# name of bucket: keep-account-####
storage=eureka-$(echo -n $tags | sed -rn 's/.+(account-[^"]+).+/\1/p')

if [ -z $storage ]; then
  exit 1
fi

mountpoint=/mnt/$storage
mkdir -p $mountpoint
gcsfuse $storage $mountpoint
