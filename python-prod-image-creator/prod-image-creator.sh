#!/bin/bash
podman build --no-cache -t python-env-3:latest .

podman save -o python-env-3_container.tar python-env-3:latest
