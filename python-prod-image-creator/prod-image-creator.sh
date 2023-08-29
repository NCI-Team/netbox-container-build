#!/bin/bash
podman build --no-cache -t python-evn-3-11:latest .

podman save -o python-evn-3-11_container.tar python-evn-3-11:latest
