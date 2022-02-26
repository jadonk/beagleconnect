# BeagleBone Green Gateway FAQ

* How to flash

Grab one of the images from here: https://github.com/beagleboard/beagleconnect#install-the-latest-software-image-for-beaglebone-green-gateway

There are two ways to update the image for ease of use:

1. The image repo. which is found here: https://rcn-ee.net/rootfs/debian-mikrobus-armhf/
2. And an actual image: https://rcn-ee.net/rootfs/debian-mikrobus-armhf/2022-02-24/bone-debian-11.2-iot-mikrobus-armhf-2022-02-24-4gb.img.xz

Now, we can install etcher from Balena if not using other methods: https://www.balena.io/etcher/

The site at https://www.balena.io/etcher/ should pick out the exact Distro you are using so you can install the correct versioning.

If not and if you want older versions, there should be a section to their site to look into currently.

Once Etcher is installed, the GUI is straight forward. With the image downloaded, use the GUI to pick the exact image from
https://rcn-ee.net/rootfs/debian-mikrobus-armhf/ or from the exact image listed on number two from this post.

Now, one must click the exact Micro SD Card from your host so you can flash the image to it.
Use a command like lsblk to find out which exact /sda, /sdb, or /sdc is the Micro SD Card in question.
For instance, without the SD Card in the host, run lsblk. You should see something similar:

```

lsblk
sda      8:0    0 931.5G  0 disk
├─sda1   8:1    0   500M  0 part /boot/efi
├─sda2   8:2    0   128M  0 part
├─sda3   8:3    0 496.4G  0 part
├─sda4   8:4    0   842M  0 part
├─sda5   8:5    0  13.3G  0 part
├─sda6   8:6    0     1G  0 part
└─sda7   8:7    0 419.4G  0 part /
sdb      8:16   1    18M  1 disk
└─sdb1   8:17   1    17M  1 part /media/messer/BEAGLEBONE


```

Now, one could place the SD Card into the host computer/development desktop and run lsblk again to see what is available.
Some new record should show once the SD Card is placed in the host with lsblk being ran, i.e. like so:

```

lsblk
sda           8:0    0 931.5G  0 disk
├─sda1        8:1    0   500M  0 part /boot/efi
├─sda2        8:2    0   128M  0 part
├─sda3        8:3    0 496.4G  0 part
├─sda4        8:4    0   842M  0 part
├─sda5        8:5    0  13.3G  0 part
├─sda6        8:6    0     1G  0 part
└─sda7        8:7    0 419.4G  0 part /
sdb           8:16   1    18M  1 disk
└─sdb1        8:17   1    17M  1 part /media/messer/BEAGLEBONE
mmcblk0     179:0    0  14.6G  0 disk
└─mmcblk0p1 179:1    0  14.6G  0 part /media/messer/4EC4-F1DF

```

You can see the newly discovered SD Card at /media/messer/4EC4-F1DF as a partition.

Now, with the GUI, one would simply ` Flashing From File ` and then ` Select Target ` , which 
is the SD Card, and then Flash the image to the SD Card with the Flash function in the GUI.

Now, the process is done by picking your image, picking the medium, and then flashing with their function ` Flash! `.

That should just about do it. Now, one can use the Micro SD Card and place it in the BeagleBone Green Gateway.

Apply 12v power from an AC Wall Outlet to the BBGG and apply the Micro USB to USB 2.0 from the target to the host.

Once in your new found system, find your way by signing in via ssh debian@beaglebone.local as user debian and password temppwd.

Now, onto the below sections for WiFi enabling. 

* How to get on WiFi

` sudo nano /etc/wpa_supplicant/wpa_supplicant-wlan0.conf `
While in the wpa_supplicant-wlan0.conf file, you may see something similar:

ctrl_interface=DIR=/run/wpa_supplicant GROUP=netdev
update_config=1
#country=US

network = {
    ssid="Wifi Name"
    psk="Passwd for Wifi Name"
}

Then, use ` sudo wpa_cli -i wlan0 reconfigure ` to let the daemon know it is aware or not.

More info. on this subject can be found here: https://forum.beagleboard.org/t/archive-2022-01-01-debian-11-x-bullseye-monthly-snapshots/31463
