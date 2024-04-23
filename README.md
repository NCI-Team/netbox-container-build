# netbox-container-build
This project is made-up of 3 parts that are focused on helping us make an easy and comfortable way to create Podman images for whitening.

Those images are used in our Netbox project, one for each environment.

> [!NOTE]
> It is important to note that 
> `netbox-image-collector` is only run when we  want to upgrade our Netbox containers.
> However when we add a new python moudle we run both `python-prod-image-creator` and `python-dev-image-creator` in their entirety.


 ## netbox-image-collector

 netbox-image-collector is a bash script to gather all the images needed to our Netbox and saves them into a tar file which is whiten and then loaded into our Netbox virtual machine.


### How to Run

 All you need is to run the script:
```
 ./image-collector.sh
```

### How to Upgrade The Images

When we want to upgrade our Netbox we will need just to change the tags to the versions we want and run the script.



## python-prod-image-creator
python-prod-image-creator contains two scripts: `requirementsfile-builder.sh` and `prod-image-creator.sh`.
The main purpose of this project is to create our podman image for the `netbox-backend flask`.


### requirementsfile-builder.sh

This bash script purpose is to create a `requirements.txt` file for the image.

The `requirements.txt` file has all the python libraries we need for the netbox-backend flask to work.


#### How to Run

```
./requirementsfile-builder.sh <python_library_to_download>
```


### prod-image-creator.sh

---

#### How to Run


In order to get the tar of the image of the netbox-backend flask we need to run prod-image-creator.sh:

```
./prod-image-creator.sh
```

## python-dev-image-creator

This project is used for creation of the flask-backend but with the addtion of vscode and the extention we want.

### How to Run

This will be run only when we add/upgrade our extensions or when we add new python libraries.

> [!IMPORTANT]
> THIS WILL BE RUN ONLY AFTER RUNNING `prod-image-creator.sh` BECAUSE IT DEPENDS ON IT

```
./dev-image-creator.sh
```
