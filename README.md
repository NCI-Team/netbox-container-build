# netbox-container-build
## Description
netbox-container-build is a collection of bash-written scripts written by the Networks team.

This project is made-up of 3 parts that are focused on making an automated way to create Podman images for whitening into an air-gap enviromnent.

Those images are used in our Netbox and Netbox Backend projects.

> [!NOTE]
> It is important to note that 
> `netbox-image-collector` is only run when we  want to upgrade our Netbox images.
> However when we add a new python moudle we run both `python-prod-image-creator` and `python-dev-image-creator` in their entirety.


 ## netbox-image-collector

 netbox-image-collector is a bash script to gather all the images needed to our Netbox and saves them into a tar file.


### How to Run

 All you need is to run the script:
```
 ./image-collector.sh
```

### How to Upgrade The Images

When we want to upgrade our Netbox we will need just to change the tags to the versions we want and run the script.



## python-prod-image-creator
python-prod-image-creator contains two scripts: `requirementsfile-builder.sh` and `prod-image-creator.sh`.
We use this project to create an image for the `Production Netbox Backend`

### requirementsfile-builder.sh

This bash script purpose is to create a `requirements.txt` file for the image.

The `requirements.txt` file has all the python libraries we need for the `Netbox Backend` to work.


#### How to Run

```
./requirementsfile-builder.sh <python_library_to_download>
```


### prod-image-creator.sh

#### How to Run
```
./prod-image-creator.sh
```

## python-dev-image-creator

This project is used for creation of the `Dev Netbox Backend`,  it is exactly like the `Production Netbox Backend` but with the addition of vscode and the extention we want.

### How to Run
> [!IMPORTANT]
> THIS WILL BE RUN ONLY AFTER RUNNING `prod-image-creator.sh` BECAUSE IT DEPENDS ON IT

```
./dev-image-creator.sh
```
