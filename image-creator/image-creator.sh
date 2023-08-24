#!/bin/bash

declare -A extensions=(
["vscode-pylance-2023.5.21"]="ms-python"
["vscodeintellicode-1.2.30"]="VisualStudioExptTeam"
["intellicode-api-usage-examples-0.2.7"]="VisualStudioExptTeam"
["remote-containers-0.293.0"]="ms-vscode-remote"
["vsc-python-indent-1.18.0"]="KevinRose"
["python-2023.9.11311005"]="ms-python"
["autodocstring-0.6.1"]="njpwerner"
["python-environment-manager-1.0.4"]="donjayamanne"
["python-extension-pack-1.7.0"]="donjayamanne"
["vscode-django-1.10.0"]="batisteo"
["prettier-vscode-9.12.0"]="esbenp"
["jinja-0.0.8"]="wholroyd"
["autopep8-2023.6.0"]="ms-python"
)


for key in "${!extensions[@]}" 
do
    FILE=./${extensions[$key]}.$key.vsix
    while [ ! -f $FILE ];
    do 
        publisher=${extensions[$key]}
        key=$(echo $key | sed 's/-\([0-9]\)/\/\1/g')
        wget -nv -w 10 --random-wait --continue https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$publisher/vsextensions/$key/vspackage
        key=$(echo $key | sed 's/\//-/g')
        mv vspackage ${extensions[$key]}.$key.vsix.gz
        gunzip -v ${extensions[$key]}.$key.vsix.gz
    done
done

podman build --no-cache -t vscodeimage .
