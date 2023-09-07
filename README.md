# netbox-container-build
This project is made-up of 3 parts that are focused on helping us make an easy and comfortable way to create Podman images for whitening.

Those images are used in our Netbox project, one for each environment.

> [!NOTE]
> It is important to note that 
> `netbox-image-collector` is only run when we > want to upgrade our Netbox containers.
> How ever when we add a new python moudle we both `python-prod-image-creator` and `python-dev-image-creator` in their entirety.


 ## netbox-image-collector

 netbox-image-collector is a bash script to gather all the images needed to our Netbox and saves them into a tar file which is whiten and then loaded into our Netbox virtual machine.

### Images
Currently we have 4 images we need for our Netbox:
1. public.ecr.aws/docker/library/redis-7.0.5-alpine3.16
2. docker.io/netboxcommunity/netbox-v3.5
3. public.ecr.aws/docker/library/redis-7.0.5-alpine3.16
4. public.ecr.aws/docker/library/haproxy-2.5.9-alpine3.16 (that we install postgres and bash on it).


### How to Run


 All you need is to run the script:
```
 ./image-collector.sh
```

### How to Upgrade The Images

When we want to upgrade our Netbox we will need just to change the tags to the versions we want and run the script.

------------------

## python-prod-image-creator
python-prod-image-creator contains two scripts: `requirementsfile-builder.sh` and `prod-image-creator.sh`.
The main purpose of this project is to create our podman image for the `netbox-backend flask`.


### requirementsfile-builder.sh
----

This bash script purpose is to create a `requirements.txt` file for the image.

The `requirements.txt` file has all the python libraries we need for the netbox-backend flask to work.

Whenever we want a new python library we don't want to download it just like that because we will need to download all of it's dependencies one by one which can be very annoying.
With this script, when run it will prompt the user what library he wants, and then it will run and install all the needed libraries and makes the 'requirements.txt' file

#### How to Run

```
./requirementsfile-builder.sh

Then write the exact name of the new python library we want.
```

### prod-image-creator.sh
----

#### How to Run


In order to get the tar of the image of the netbox-backend flask we need to run prod-image-creator.sh:

```
./prod-image-creator.sh
```

## python-dev-image-creator

python-dev-image-creator contains 3 files in it:
1. Containerfile
2. dev-image-creator.sh
3. download-vs-code-server.sh

The only file we will update and edit is the `dev-image-creator.sh` because it has the extensions we want on our dev-netbox-backend.
To add new extensions all you need to do it to add an extension for path and it tag into the `extensions` dictonary like that:
```
["vscode-pylance-2023.5.21"]="ms-python"
```

### How to Run

This will be ran only when we add/upgrade our extensions or when we add new python libraries.

> [!IMPORTANT]
> THIS WILL BE RUN ONLY AFTER RUNNING `prod-image-creator.sh` BECAUSE IT DEPENDS ON IT

```
./dev-image-creator.sh
```





