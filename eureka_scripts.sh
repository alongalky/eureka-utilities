#!/bin/bash

vm_id=$(curl -s -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/name")
eureka_endpoint=$(echo 'y' | gcloud compute instances describe $vm_id 2>&1 | grep -A 1 eureka_endpoint | grep value | awk '{print $2}')
response=$(curl -s $eureka_endpoint/api/_internal/scripts?vm_id=$vm_id)

script=$(jq '.script' <<<$response | sed -r 's/^"(.*)"$/\1/')

echo -e $script >/tmp/eureka_script.sh
bash /tmp/eureka_script.sh &
