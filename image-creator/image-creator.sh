#!/bin/bash

declare -A extensions=(
["VisualStudioExptTeam"]="vscodeintellicode"
["VisualStudioExptTeam"]="intellicode-api-usage-examples"
["ms-python"]="vscode-pylance"
["ms-vscode-remote"]="remote-containers"
)

for key in "${!extensions[@]}" 
do
    wget -nv https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$key/vsextensions/${extensions[$key]}/latest/vspackage
    mv vspackage $key.${extensions[$key]}-latest.vsix.gz
    gunzip -v $key.${extensions[$key]}-latest.vsix.gz
done

podman build -t vscodeimage .

