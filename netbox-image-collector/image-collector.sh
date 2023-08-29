#!/bin/bash
declare -A images=(
["public.ecr.aws/docker/library/redis"]="7.0.5-alpine3.16"
["public.ecr.aws/docker/library/haproxy"]="2.5.9-alpine3.16"
["public.ecr.aws/bitnami/postgresql-repmgr"]="14.5.0-debian-11-r17"
["docker.io/netboxcommunity/netbox"]="v3.5"
)

for key in "${!images[@]}" 
do
    podman pull "$key:${images[$key]}"
done

echo FROM public.ecr.aws/docker/library/haproxy:2.5.9-alpine3.16 > ./Containerfile
echo USER root >> ./Containerfile
echo RUN apk add postgresql bash >> ./Containerfile

podman build --no-cache -t haproxy-pg-bash:2.5.9-alpine3.16 .

images["haproxy-pg-bash"]="${images["public.ecr.aws/docker/library/haproxy"]}"
unset images["public.ecr.aws/docker/library/haproxy"]

# Create the command for saving and removing images
command="podman save -o netbox-images.tar"

for key in "${!images[@]}"
do
  command+=" $key:${images[$key]}"
done

# Execute the command
$command

rm Containerfile