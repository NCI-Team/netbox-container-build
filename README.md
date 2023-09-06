# netbox-container-build
--------------------------
This project is made-up of 3 parts that are focused on helping us make an easy and comfortable way to create Podman images for whitening.


 #netbox-image-collector
 -----------------------
 netbox-image-collector is a bash script to gather all the images needed to our Netbox and saves them into a tar file.

Images
---
Currently we have 4 images we need for our Netbox:
1. public.ecr.aws/docker/library/redis-7.0.5-alpine3.16
2. docker.io/netboxcommunity/netbox-v3.5
3. public.ecr.aws/docker/library/redis-7.0.5-alpine3.16
4. public.ecr.aws/docker/library/haproxy-2.5.9-alpine3.16 (that we install postgres and bash on it).


How to run
---

 All you need is to run the script:

 `./image-collector.sh`


How to Upgrade The Images
----

When we want to upgrade our netbox we will need just to change the tags to the versions we want and run the script.

