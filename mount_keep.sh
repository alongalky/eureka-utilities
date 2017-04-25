#!/bin/bash
tags=$(curl -H Metadata-Flavor:Google http://metadata/computeMetadata/v1/instance/tags)
# name of bucket: keep-account-####
storage=keep-$(echo $tags | sed -r 's/.+(account-[^"]+).+/\1/')
gcsfuse $storage /keep