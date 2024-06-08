#!/bin/bash

#### Reminder to improve this part of the code.
declare -A extensions=(
    ["vscode-pylance-latest"]="ms-python"
    ["vscodeintellicode-latest"]="VisualStudioExptTeam"
    ["intellicode-api-usage-examples-latest"]="VisualStudioExptTeam"
    ["remote-containers-latest"]="ms-vscode-remote"
    ["vsc-python-indent-latest"]="KevinRose"
    ["python-latest"]="ms-python"
    ["autodocstring-latest"]="njpwerner"
    ["python-extension-pack-latest"]="donjayamanne"
    ["vscode-django-latest"]="batisteo"
    ["prettier-vscode-latest"]="esbenp"
    ["jinja-latest"]="wholroyd"
    ["autopep8-latest"]="ms-python"
)

if [ ! -d "./extensions" ]; then
    mkdir ./extensions
fi

cd ./extensions

for key in "${!extensions[@]}"
do
    FILE=./${extensions[$key]}.$key.vsix
    while [ ! -f $FILE ];
    do
        publisher=${extensions[$key]}
        key=$(echo $key | sed 's/-latest/\/latest/g')
        wget -nv -w 10 --random-wait --continue https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$publisher/vsextensions/$key/vspackage
        key=$(echo $key | sed 's/\//-/g')
        mv vspackage ${extensions[$key]}.$key.vsix.gz
        gunzip -v ${extensions[$key]}.$key.vsix.gz
    done
done

cd ..

podman build --no-cache -t python-env-3-development:latest .
podman save -o python-env-3-development_container.tar python-env-3-development:latest
