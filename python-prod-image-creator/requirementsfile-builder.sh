#!/bin/bash

read -p 'Python Package To Download: ' python_package
podman build -t python-env-dev .
podman run -dit --name=python_develop python-env-dev bash
podman exec -it python_develop pip3 install $python_package
podman exec -it python_develop bash -c "pip3 freeze > /tmp/requirements.txt"
podman cp python_develop:/tmp/requirements.txt ./requirements.txt
podman rm -f python_develop
