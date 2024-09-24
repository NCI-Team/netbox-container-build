#!/bin/bash

#### Reminder to improve this part of the code.
declare -A extensions=(
    ["vscode-pylance"]="ms-python"
    ["vscodeintellicode"]="VisualStudioExptTeam"
    ["intellicode-api-usage-examples"]="VisualStudioExptTeam"
    ["remote-containers"]="ms-vscode-remote"
    ["vsc-python-indent"]="KevinRose"
    ["python"]="ms-python"
    ["autodocstring"]="njpwerner"
    ["python-extension-pack"]="donjayamanne"
    ["vscode-django"]="batisteo"
    ["prettier-vscode"]="esbenp"
    ["jinja"]="wholroyd"
    ["autopep8"]="ms-python"
    ["markdown-preview-github-styles"]="bierner"
    ["gitlens"]="eamodio"
    ["vscode-peacock"]="johnpapa"
    ["codescene-vscode"]="CodeScene"
    ["vscode-markdownlint"]="DavidAnson"
)

if [ ! -d "./extensions" ]; then
    mkdir ./extensions
fi

cd ./extensions

for key in "${!extensions[@]}"
do
    version="latest"
    if [ $key -eq "python" ]; then
        $version = "-2024.14.1"
    fi
    
    FILE=${extensions[$key]}.$key-$version.vsix
    while [ ! -f ./$FILE ];
    do
        publisher=${extensions[$key]}
        
        wget -nv -w 10 --random-wait --continue https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$publisher/vsextensions/$key/$version/vspackage
        mv vspackage $FILE
    done
done

cd ..

podman build --no-cache -t python-env-3-development:latest .
podman save -o python-env-3-development_container.tar python-env-3-development:latest
