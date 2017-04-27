#!/bin/bash

machinename=$(curl -s -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/name")
eureka_endpoint=$(echo 'y' | gcloud compute instances describe $machinename 2>&1 | grep -A 1 eureka_endpoint | grep value | awk '{print $2}')
response=$(curl -s $eureka_endpoint/api/_internal/scripts?machine_id=$machinename)

script=$(jq '.script' <<<$response | sed -r 's/^"(.*)"$/\1/')

eval $script &
