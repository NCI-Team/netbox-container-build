#!/bin/bash

declare -A extensions=(
["vscode-pylance"]="ms-python"
["vscodeintellicode"]="VisualStudioExptTeam"
["intellicode-api-usage-examples"]="VisualStudioExptTeam"
["remote-containers"]="ms-vscode-remote"
["vsc-python-indent"]="KevinRose"
["python"]="ms-python"
["autodocstring"]="njpwerner"
["python-environment-manager"]="donjayamanne"
["python-extension-pack"]="donjayamanne"
["vscode-django"]="batisteo"
["prettier-vscode"]="esbenp"
["jinja"]="wholroyd"
)

for key in "${!extensions[@]}" 
do
    FILE=./${extensions[$key]}.$key-latest.vsix
    if [ ! -f $FILE ]; then
        wget -nv -w 10 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/${extensions[$key]}/vsextensions/$key/latest/vspackage
        mv vspackage ${extensions[$key]}.$key-latest.vsix.gz
        gunzip -v ${extensions[$key]}.$key-latest.vsix.gz
done

podman build -t vscodeimage .
