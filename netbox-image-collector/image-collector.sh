#!/bin/bash

haproxy="public.ecr.aws/docker/library/haproxy"
haproxy_tag="2.5.9-alpine3.16"

declare -A images=(
["public.ecr.aws/docker/library/redis"]="7.0.5-alpine3.16"
[$haproxy]=$haproxy_tag
["public.ecr.aws/bitnami/postgresql-repmgr"]="14.5.0-debian-11-r17"
["docker.io/netboxcommunity/netbox"]="v3.5"
)

for key in "${!images[@]}" 
do
    podman pull "$key:${images[$key]}"
done

echo FROM $haproxy:$haproxy_tag > ./Containerfile
echo USER root >> ./Containerfile
echo RUN apk add postgresql bash >> ./Containerfile

podman build --no-cache -t haproxy-pg-bash:$haproxy_tag .

images["haproxy-pg-bash"]="$haproxy_tag"
unset images[$haproxy]

# Create the command for saving and removing images
command="podman save -o netbox-images.tar"

for key in "${!images[@]}"
do
  command+=" $key:${images[$key]}"
done

# Execute the command
$command

rm ./Containerfile