podman build --no-cache -t s3cmd-image:latest .
podman save -o s3cmd-image.tar localhost/s3cmd-image:latest