# Using Linux, Zephyr & Greybus for IoT with the CC1352R SensorTag

- [Introduction](#introduction)
  * [Why??](#why--)
  * [History](#history)
- [Hardware Requirements](#hardware-requirements)
- [Prerequisites](#prerequisites)
- [Console (Minicom)](#console--minicom-)
  * [Set Up Minicom](#set-up-minicom)
  * [Run Minicom](#run-minicom)
- [Zephyr](#zephyr)
  * [Add the Fork](#add-the-fork)
  * [Build and Flash Zephyr](#build-and-flash-zephyr)
  * [The Zephyr Shell](#the-zephyr-shell)
    + [Zephyr Shell: IEEE 802.15.4 commands](#zephyr-shell--ieee-802154-commands)
    + [Zephyr Shell: Network Commands](#zephyr-shell--network-commands)
- [Linux](#linux)
  * [Probe the IEEE 802.15.4 Device Driver](#probe-the-ieee-802154-device-driver)
  * [Set the 802.15.4 Physical and Link-Layer Parameters](#set-the-802154-physical-and-link-layer-parameters)
  * [Create a 6LowPAN Network Interface](#create-a-6lowpan-network-interface)
- [Ping Pong](#ping-pong)
  * [Broadcast Ping](#broadcast-ping)
  * [Ping Zephyr](#ping-zephyr)
  * [Ping Linux](#ping-linux)
  * [Assign a Static Address](#assign-a-static-address)
- [Greybus](#greybus)
    + [Build and probe Greybus Kernel Modules](#build-and-probe-greybus-kernel-modules)
    + [Build and Run Gbridge](#build-and-run-gbridge)
- [Blinky!](#blinky-)
- [Read I2C Registers](#read-i2c-registers)
- [Conclusion](#conclusion)

# Introduction
This document describes, in some detail, the steps required to use [Linux](https://en.wikipedia.org/wiki/Linux) workstation and the [Greybus](https://lwn.net/Articles/715955/) protocol, over an IEEE 802.15.4 wireless link, to blink an LED on a [Zephyr](https://zephyrproject.org) device.

## Why??
Good question. Blinking an LED is kind of the [Hello, World](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program) of the hardware community. In this case, we're less interested in the mechanics of switching a GPIO to drive some current through an LED and more interested in how that happens with the [Internet of Things (IoT)](https://en.wikipedia.org/wiki/Internet_of_things).

There are several existing network and application layers that are driven by corporate heavyweights and industry consortiums, but relatively few that are community driven and, more specifically, even fewer that have the ability to integrate so tightly with the Linux kernel.

The goal here is to provide a community-maintained, developer-friendly, and open-source protocol for the Internet of Things using the Greybus Protocol, and blinking an LED using Greybus is the simplest proof-of-concept for that. All that is required is a reliable transport.

## History

There are a few technologies at the core of this demonstration, and far too much background information to describe adequately here, so they are simply listed below for brevity
* [Project Ara](https://en.wikipedia.org/wiki/Project_Ara)
* [IPv6](https://en.wikipedia.org/wiki/IPv6) (via [6LoWPAN](https://en.wikipedia.org/wiki/6LoWPAN))
* Zephyr support for [IEEE 802.15.4](https://docs.zephyrproject.org/latest/reference/networking/ieee802154.html)
* [Greybus](https://youtu.be/UzRq8jAHAxU) originally from [Project Ara](https://youtu.be/UzRq8jAHAxU)
* [Using Greybus for IoT](https://youtu.be/7H50pv-4YXw)

In short, Greybus is an application layer protocol that can be described as a "bus transport" in that it conveys bus-specific messages back and forth between Linux and a connected device. The physical bus is attached to the connected device, which could be running Linux or a variety of Real-Time Operating Systems. Meanwhile, on the Linux side, a virtual bus is created corresponding to the physical bus on the connected device. To the user, this virtual bus (be it /dev/gpiochip0, /dev/i2c5, etc) appears and functions exactly the same. Greybus is the protocol used to exchange bus-specific messages and data between Linux and the connected device.

The major advantage there is that drivers can be well maintained in Linux rather than buried in microcontroller firmware.

Greybus currently supports several busses, including:
* USB
* I2C
* GPIO
* PWM
* SPI
* UART
* SDIO
* Camera (V4L)
* LED (with various programmability)
* AUDIO (I2S)

# Hardware Requirements
* a Linux workstation running [Ubuntu Bionic](https://releases.ubuntu.com/18.04.4)
  * Only x86_64 is supported at this time
* a USB-Serial adapter
* a J-Link JTAG tool
* a board that is supported by Zephyr with support for IEEE 802.15.4
  * In this example, we use the [cc1352r1_sensortag](https://www.ti.com/tool/LPSTK-CC1352R)
  * Available for purchase directly from [Texas Instruments](https://www.ti.com/tool/LPSTK-CC1352R) or a distributor
  * Connect DIO12 (RXD) and DIO13 (TXD) as well as GND to the appropriate pins on your serial adapter 
* a USB IEEE 802.15.4 adapter
  * In this example, we use the [atusb](http://downloads.qi-hardware.com/people/werner/wpan/web)
  * Available for purchase from [sysmocom](http://shop.sysmocom.de/products/atusb)
  * This part is [OSHW](https://www.oshwa.org/) (i.e. all CAD files and firmware source is available) for those who choose to create their own.

# Prerequisites
* Zephyr environment is set up according to the [Getting Started Guide](https://docs.zephyrproject.org/latest/getting_started/index.html)
  * Please use the Zephyr SDK when installing a toolchain above
* [Zephyr SDK](https://docs.zephyrproject.org/latest/getting_started/index.html#install-a-toolchain) is installed at ~/zephyr-sdk-0.11.2 (any later version should be fine as well)
* Zephyr board is connected via USB

# Console (Minicom)
In order to see diagnostic messages or to run certain commands on the Zephyr device we will require a terminal open to the device console. In this case, we use [minicom](https://en.wikipedia.org/wiki/Minicom). We will run it twice; the first time for setup using root privileges, and the a second time as a regular user.

## Set Up Minicom
```console
sudo minicom -s
```
You should see the options shown below:
```console
            +-----[configuration]------+                                     
            | Filenames and paths      |                                     
            | File transfer protocols  |                                     
            | Serial port setup        |                                     
            | Modem and dialing        |                                     
            | Screen and keyboard      |
            | Save setup as dfl        |
            | Save setup as..          |
            | Exit                     |
            | Exit from Minicom        |
            +--------------------------+
```
1. Select *Serial port setup*, hit *Enter*
1. Press 'A' for *Serial Device*, type in `/dev/ttyACM0`, and hit *Enter* again
1. Press 'E' for *Bps/Par/Bits*, press 'E' for `115200`, and 'Q' for *8-N-1*, and hit *Enter* again
1. Press 'F' to set *Hardware Flow Control: No*
1. Press *Down* to *Save setup as..*, and then enter `ttyACM0` when prompted, and hit *Enter*
1. Press *Down* to *Exit from Minicom* and finally hit *Enter* again to exit setup

## Run Minicom
Now, we'll open a terminal to Zephyr using the newly created setup with the command below.
```console
minicom ttyACM0
```
Enter the following key combinations
* `Ctrl+A, U` -> `Add carriage return ON`
* `Ctrl+A, W` -> `Linewrap ON`
* `Ctrl+A, C` -> clear the screen

To exit minicom (later), enter `Ctrl+A, X`.

# Zephyr
## Add the Fork

For the time being, Greybus must remain outside of the main Zephyr repository. Currently, it is just in a Zephyr fork, but it should be converted to a proper [Module (External Project)](https://docs.zephyrproject.org/latest/guides/modules.html). This is for a number of reasons, but mainly there must be:
* specifications for authentication and encryption
* specifications for joining and rejoining wireless networks
* specifications for discovery

Therefore, in order to reproduce this example, please run the following in your zephyr directory.
```console
git remote add greybus https://github.com/cfriedt/zephyr.git
git fetch greybus
git checkout -b greybus-service-lpc2020 greybus/greybus-service-lpc2020
west update
```

## Build and Flash Zephyr
Here, we will build and flash the Zephyr [greybus_net sample](https://github.com/cfriedt/zephyr/tree/greybus-sockets/samples/subsys/greybus/net) to our device.

1. Open a separate terminal window (`Ctrl+Shift+N`) or simply create a new tab in your existing terminal (`Ctrl+Shift+T`) so that you can see both or quickly switch between `minicom` and the shell.
1. Now in the shell, change to the `zephyrproject/zephyr` directory
1. Edit the file `~/.zephyrrc` and place the following text inside of it
    ```
    export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
    export ZEPHYR_SDK_INSTALL_DIR=~/zephyr-sdk-0.11.2
    ```
1. Set up the required Zephyr environment variables via `source zephyr-env.sh`
1. Build the project
    ```
    BOARD=cc1352r1_launchxl west build samples/subsys/greybus/net --pristine --build-dir build/greybus_launchpad -- \
      -DCONF_FILE="prj.conf overlay-802154.conf"
    ```
1. Ensure that the last part of the build process looks somewhat like this:
    ```console
    ...
    Memory region         Used Size  Region Size  %age Used
               FLASH:      261996 B         1 MB     24.99%
                SRAM:       50879 B       256 KB     19.41%
            IDT_LIST:         152 B         2 KB      7.42%
    [245/245] Linking C executable zephyr/zephyr.elf
    ```
1. Flash the firmware to your device using `BOARD=cc1352r1_launchxl west flash --build-dir build/greybus_launchpad`

## The Zephyr Shell

After flashing, you should observe the something matching the following output in `minicom`.
```
*** Booting Zephyr OS build zephyr-v2.3.0-1435-g40c0ed940d71  ***
[00:00:00.011,932] <inf> net_config: Initializing network
[00:00:00.111,938] <inf> net_config: IPv6 address: fe80::6c42:bc1c:4b:1200
[00:00:00.112,121] <dbg> greybus_service.greybus_service_init: Greybus initializing..
[00:00:00.112,426] <dbg> greybus_transport_tcpip.gb_transport_backend_init: Greybus TCP/IP Transport initializing..
[00:00:00.112,579] <dbg> greybus_transport_tcpip.netsetup: created server socket 0 for cport 0
[00:00:00.112,579] <dbg> greybus_transport_tcpip.netsetup: setting socket options for socket 0
[00:00:00.112,609] <dbg> greybus_transport_tcpip.netsetup: binding socket 0 (cport 0) to port 4242
[00:00:00.112,640] <dbg> greybus_transport_tcpip.netsetup: listening on socket 0 (cport 0)
[00:00:00.112,823] <dbg> greybus_transport_tcpip.netsetup: created server socket 1 for cport 1
[00:00:00.112,823] <dbg> greybus_transport_tcpip.netsetup: setting socket options for socket 1
[00:00:00.112,854] <dbg> greybus_transport_tcpip.netsetup: binding socket 1 (cport 1) to port 4243
[00:00:00.112,854] <dbg> greybus_transport_tcpip.netsetup: listening on socket 1 (cport 1)
[00:00:00.113,037] <inf> net_config: IPv6 address: fe80::6c42:bc1c:4b:1200
[00:00:00.113,250] <dbg> greybus_transport_tcpip.netsetup: created server socket 2 for cport 2
[00:00:00.113,250] <dbg> greybus_transport_tcpip.netsetup: setting socket options for socket 2
[00:00:00.113,281] <dbg> greybus_transport_tcpip.netsetup: binding socket 2 (cport 2) to port 4244
[00:00:00.113,311] <dbg> greybus_transport_tcpip.netsetup: listening on socket 2 (cport 2)
[00:00:00.113,494] <dbg> greybus_transport_tcpip.netsetup: created server socket 3 for cport 3
[00:00:00.113,494] <dbg> greybus_transport_tcpip.netsetup: setting socket options for socket 3
[00:00:00.113,525] <dbg> greybus_transport_tcpip.netsetup: binding socket 3 (cport 3) to port 4245
[00:00:00.113,555] <dbg> greybus_transport_tcpip.netsetup: listening on socket 3 (cport 3)
[00:00:00.113,861] <inf> greybus_transport_tcpip: Greybus TCP/IP Transport initialized
[00:00:00.116,149] <inf> greybus_service: Greybus is active
[00:00:00.116,546] <dbg> greybus_transport_tcpip.accept_loop: calling poll
uart:~$ 
```

The line beginning with `***` is the Zephyr boot banner.

Lines beginning with a timestamp of the form `[H:m:s.us]` are Zephyr kernel messages.

Lines beginning with `uart:~$ ` indicates that the Zephyr shell is prompting you to enter a command.

From the informational messages shown, we observe the following.
* Zephyr is configured with the following [link-local IPv6 address](https://en.wikipedia.org/wiki/Link-local_address#IPv6) `fe80::cf99:a11c:4b:1200`
* It is listening for (both) TCP and UDP traffic on port 4242

However, what the log messages do *not* show (which will come into play later), are 2 critical pieces of information:
1. The RF Channel: 
    As you may have guessed, IEEE 802.15.4 devices are only able to communicate with each other if they are using
    the same frequency to transmit and recieve data. This information is part of the Physical Layer.
1. The [PAN identifier](https://www.silabs.com/community/wireless/proprietary/knowledge-base.entry.html/2019/10/04/connect_tutorial6-ieee802154addressing-rapc): 
    IEEE 802.15.4 devices are only be able to communicate with one another if they use the *same* PAN ID. This permits multiple networks (PANs) on the same frequency. This information is part of the Data Link Layer.

If we type `help` in the shell and hit *Enter*, we're prompted with the following:
```console
Please press the <Tab> button to see all available commands.
You can also use the <Tab> button to prompt or auto-complete all commands or its subcommands.
You can try to call commands with <-h> or <--help> parameter for more information.
Shell supports following meta-keys:
Ctrl+a, Ctrl+b, Ctrl+c, Ctrl+d, Ctrl+e, Ctrl+f, Ctrl+k, Ctrl+l, Ctrl+n, Ctrl+p, Ctrl+u, Ctrl+w
Alt+b, Alt+f.
Please refer to shell documentation for more details.
```
So after hitting *Tab*, we see that there are several interesting commands we can use for additional information.
```console
uart:~$ 
  clear       help        history     ieee802154  log         net
  resize      sample      shell
```

### Zephyr Shell: IEEE 802.15.4 commands
Entering `ieee802154 help`, we see
```console
uart:~$ ieee802154 help
ieee802154 - IEEE 802.15.4 commands
Subcommands:
  ack             :<set/1 | unset/0> Set auto-ack flag
  associate       :<pan_id> <PAN coordinator short or long address (EUI-64)>
  disassociate    :Disassociate from network
  get_chan        :Get currently used channel
  get_ext_addr    :Get currently used extended address
  get_pan_id      :Get currently used PAN id
  get_short_addr  :Get currently used short address
  get_tx_power    :Get currently used TX power
  scan            :<passive|active> <channels set n[:m:...]:x|all> <per-channel
                   duration in ms>
  set_chan        :<channel> Set used channel
  set_ext_addr    :<long/extended address (EUI-64)> Set extended address
  set_pan_id      :<pan_id> Set used PAN id
  set_short_addr  :<short address> Set short address
  set_tx_power    :<-18/-7/-4/-2/0/1/2/3/5> Set TX power
```
We get the missing Channel number (frequency) with the command `ieee802154 get_chan`.
```console
uart:~$ ieee802154 get_chan
Channel 26
```
We get the missing PAN ID with the command `ieee802154 get_pan_id`.
```console
uart:~$ ieee802154 get_pan_id
PAN ID 43981 (0xabcd)
```

### Zephyr Shell: Network Commands
Additionally, we may query the IPv6 information of the Zephyr device.
```console
uart:~$ net iface

Interface 0x20002b20 (IEEE 802.15.4) [1]
========================================
Link addr : CD:99:A1:1C:00:4B:12:00
MTU       : 125
IPv6 unicast addresses (max 3):
        fe80::cf99:a11c:4b:1200 autoconf preferred infinite
        2001:db8::1 manual preferred infinite
IPv6 multicast addresses (max 4):
        ff02::1
        ff02::1:ff4b:1200
        ff02::1:ff00:1
IPv6 prefixes (max 2):
        <none>
IPv6 hop limit           : 64
IPv6 base reachable time : 30000
IPv6 reachable time      : 16929
IPv6 retransmit timer    : 0
```
And we see that the static IPv6 address (`2001:db8::1`) from `samples/net/sockets/echo_server/prj.conf` is present and configured. While the statically configured IPv6 address is useful, it isn't 100% necessary.

# Linux
## Probe the IEEE 802.15.4 Device Driver
On the Linux machine, we've inserted our atusb device, and should now be able to run `sudo modprobe atusb`. The kernel should provide some information messages (via `dmesg`) to indicate that the device is recognized.

```console
[704054.909350] usb 1-1.3: ATUSB: AT86RF231 version 2
[704054.909602] usb 1-1.3: Firmware: major: 0, minor: 2, hardware type: ATUSB (2)
[704054.910097] usb 1-1.3: Firmware: build #24 Wed 20 May 15:19:58 CEST 2015
[704054.927872] usbcore: registered new interface driver atusb
```

We should now be able to see the IEEE 802.15.4 network device by entering `ip a show wpan0`.
```console
$ ip a show wpan0
36: wpan0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 123 qdisc fq_codel state UNKNOWN group default qlen 300
    link/ieee802.15.4 3e:7d:90:4d:8f:00:76:a2 brd ff:ff:ff:ff:ff:ff:ff:ff
```
But wait, that is not an IP address! It's the hardware address of the 802.15.4 device. So, in order to associate it with an IP address, we need to run a couple of other commands (thanks to [cakelab.org](http://wpan.cakelab.org/)).

## Set the 802.15.4 Physical and Link-Layer Parameters
1. First, get the phy number for the `wpan0` device
    ```console
    $ iwpan list 
    wpan_phy phy0
    supported channels:
    	page 0: 11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26 
    current_page: 0
    current_channel: 26,  2480 MHz
    cca_mode: (1) Energy above threshold
    cca_ed_level: -77
    tx_power: 3
    capabilities:
    	iftypes: node,monitor 
    	channels:
    		page 0: 
    			[11]  2405 MHz, [12]  2410 MHz, [13]  2415 MHz, 
    			[14]  2420 MHz, [15]  2425 MHz, [16]  2430 MHz, 
    			[17]  2435 MHz, [18]  2440 MHz, [19]  2445 MHz, 
    			[20]  2450 MHz, [21]  2455 MHz, [22]  2460 MHz, 
    			[23]  2465 MHz, [24]  2470 MHz, [25]  2475 MHz, 
    			[26]  2480 MHz  
    	tx_powers: 
    			3 dBm, 2.8 dBm, 2.3 dBm, 1.8 dBm, 1.3 dBm, 0.7 dBm, 
    			0 dBm, -1 dBm, -2 dBm, -3 dBm, -4 dBm, -5 dBm, 
    			-7 dBm, -9 dBm, -12 dBm, -17 dBm, 
    	cca_ed_levels: 
    			-91 dBm, -89 dBm, -87 dBm, -85 dBm, -83 dBm, -81 dBm, 
    			-79 dBm, -77 dBm, -75 dBm, -73 dBm, -71 dBm, -69 dBm, 
    			-67 dBm, -65 dBm, -63 dBm, -61 dBm, 
    	cca_modes: 
    		(1) Energy above threshold
    		(2) Carrier sense only
    		(3, cca_opt: 0) Carrier sense with energy above threshold (logical operator is 'and')
    		(3, cca_opt: 1) Carrier sense with energy above threshold (logical operator is 'or')
    	min_be: 0,1,2,3,4,5,6,7,8 
    	max_be: 3,4,5,6,7,8 
    	csma_backoffs: 0,1,2,3,4,5 
    	frame_retries: 3 
    	lbt: false
    ```
1. Next, set the Channel for the 802.15.4 device on the Linux machine
    ```console
    sudo iwpan phy phy0 set channel 0 26
    ```
1. Then, set the PAN identifier for the 802.15.4 device on the Linux machine
    ```console
    sudo iwpan dev wpan0 set pan_id 0xabcd
    ```
## Create a 6LowPAN Network Interface
1. Associate the `wpan0` device to a new, 6lowpan network interface
    ```console
    sudo ip link add link wpan0 name lowpan0 type lowpan
    ```
1. Finally, set the links up for both `wpan0` and `lowpan0`
    ```console
    sudo ip link set wpan0 up
    sudo ip link set lowpan0 up
    ```

We
should observe something like the
following when we run `ip a show lowpan0`. 
```console
ip a show lowpan0
37: lowpan0@wpan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1280 qdisc noqueue state UNKNOWN group default qlen 1000
    link/6lowpan 9e:0b:a4:e8:00:d3:45:53 brd ff:ff:ff:ff:ff:ff:ff:ff
    inet6 fe80::9c0b:a4e8:d3:4553/64 scope link 
       valid_lft forever preferred_lft forever
```

# Ping Pong
## Broadcast Ping

Now, perform a broadcast ping to see what else is listening on `lowpan0`.
```console
$ ping6 -I lowpan0 ff02::1
PING ff02::1(ff02::1) from fe80::9c0b:a4e8:d3:4553%lowpan0 lowpan0: 56 data bytes
64 bytes from fe80::9c0b:a4e8:d3:4553%lowpan0: icmp_seq=1 ttl=64 time=0.099 ms
64 bytes from fe80::9c0b:a4e8:d3:4553%lowpan0: icmp_seq=2 ttl=64 time=0.125 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=2 ttl=64 time=17.3 ms (DUP!)
64 bytes from fe80::9c0b:a4e8:d3:4553%lowpan0: icmp_seq=3 ttl=64 time=0.126 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=3 ttl=64 time=9.60 ms (DUP!)
64 bytes from fe80::9c0b:a4e8:d3:4553%lowpan0: icmp_seq=4 ttl=64 time=0.131 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=4 ttl=64 time=14.9 ms (DUP!)
```

Yay! We have pinged (pung?) the Zephyr device over IEEE 802.15.4 using 6LowPAN!

## Ping Zephyr
We can ping the Zephyr device directly without a broadcast ping too, of course.
```console
$ ping6 -I lowpan0 fe80::cf99:a11c:4b:1200
PING fe80::cf99:a11c:4b:1200(fe80::cf99:a11c:4b:1200) from fe80::9c0b:a4e8:d3:4553%lowpan0 lowpan0: 56 data bytes
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=1 ttl=64 time=16.0 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=2 ttl=64 time=13.8 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=3 ttl=64 time=9.77 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=5 ttl=64 time=11.5 ms
```
## Ping Linux
Similarly, we can ping the Linux host from the Zephyr shell.
```console
uart:~$ net ping --help
ping - Ping a network host.
Subcommands:
  --help  :'net ping [-c count] [-i interval ms] <host>' Send ICMPv4 or ICMPv6
           Echo-Request to a network host.
$ net ping -c 5 fe80::9c0b:a4e8:d3:4553
PING fe80::9c0b:a4e8:d3:4553
8 bytes from fe80::9c0b:a4e8:d3:4553 to fe80::cf99:a11c:4b:1200: icmp_seq=0 ttl=64 rssi=110 time=11 ms
8 bytes from fe80::9c0b:a4e8:d3:4553 to fe80::cf99:a11c:4b:1200: icmp_seq=1 ttl=64 rssi=126 time=9 ms
8 bytes from fe80::9c0b:a4e8:d3:4553 to fe80::cf99:a11c:4b:1200: icmp_seq=2 ttl=64 rssi=128 time=13 ms
8 bytes from fe80::9c0b:a4e8:d3:4553 to fe80::cf99:a11c:4b:1200: icmp_seq=3 ttl=64 rssi=126 time=10 ms
8 bytes from fe80::9c0b:a4e8:d3:4553 to fe80::cf99:a11c:4b:1200: icmp_seq=4 ttl=64 rssi=126 time=7 ms
```

## Assign a Static Address

So far, we have been using IPv6 Link-Local addressing. However, the Zephyr application is configured to use a statically configured IPv6 address as well which is, namely `2001:db8::1`.

If we add a similar static IPv6 address to our Linux IEEE 802.15.4 network interface, `lowpan0`, then we should expect to be able to reach that as well.

In Linux, run the following
```console
sudo ip -6 addr add 2001:db8::2/64 dev lowpan0
```
We can verify that the address has been set by examining the `lowpan0` network interface again.
```console
$ ip a show lowpan0
37: lowpan0@wpan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1280 qdisc noqueue state UNKNOWN group default qlen 1000
    link/6lowpan 9e:0b:a4:e8:00:d3:45:53 brd ff:ff:ff:ff:ff:ff:ff:ff
    inet6 2001:db8::2/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fe80::9c0b:a4e8:d3:4553/64 scope link 
       valid_lft forever preferred_lft forever
```

Lastly, ping the statically configured IPv6 address of the Zephyr device.
```console
$ ping6 2001:db8::1
PING 2001:db8::1(2001:db8::1) 56 data bytes
64 bytes from 2001:db8::1: icmp_seq=2 ttl=64 time=53.7 ms
64 bytes from 2001:db8::1: icmp_seq=3 ttl=64 time=13.1 ms
64 bytes from 2001:db8::1: icmp_seq=4 ttl=64 time=22.0 ms
64 bytes from 2001:db8::1: icmp_seq=5 ttl=64 time=22.7 ms
64 bytes from 2001:db8::1: icmp_seq=6 ttl=64 time=18.4 ms
```

Now that we have set up a reliable transport, let's move on to the application layer.

# Greybus

Hopefully the videos listed earlier provide a sufficient foundation to understand what will happen shortly. However, there is still a bit more preparation required.

### Build and probe Greybus Kernel Modules

Greybus was originally intended to work exclusively on the UniPro physical layer. However, we're using RF as our physical layer and TCP/IP as our transport. As such, there was need to be able to communicate with the Linux Greybus facilities through userspace, and out of that need arose gb-netlink. The Netlink Greybus module actually does not care about the physical layer, but is happy to usher Greybus messages back and forth between the kernel and userspace.

Build and probe the gb-netlink modules (as well as the other Greybus modules) with the following:
```console
cd ${WORKSPACE}
git clone https://github.com/friedtco/greybus.git
cd greybus
make -j`nproc --all`
./gbprobe.sh
```

### Build and Run Gbridge

The gbridge utility was created as a proof of concept to abstract the Greybus Netlink datapath among several reliable transports. For the purposes of this tutorial, we'll be using it as a TCP/IP bridge.

To run `gbridge`, perform the following:
```console
cd gbridge
autoreconf -vfi
GBNETLINKDIR=${PWD}/../greybus \
  ./configure --enable-uart --enable-tcpip --disable-gbsim --enable-netlink --disable-bluetooth
make -j`nproc --all`
sudo make install
gbridge
```

# Blinky!

Now that we have set up a reliable TCP transport, and set up the Greybus modules in the Linux kernel, and used Gbridge to connect a Greybus node to the Linux kernel via TCP/IP, we can now get to the heart of the demonstration!

First, save the following script as `blinky.sh`.
```bash
#!/bin/bash
​
# Blinky Demo for CC1352R SensorTag
​
# /dev/gpiochipN that Greybus created
CHIP="$(gpiodetect | grep greybus_gpio | head -n 1 | awk '{print $1}')"
​
# red, green, blue LED pins
RED=6
GREEN=7
BLUE=21
​
# Bash array for pins and values
PINS=($RED $GREEN $BLUE)
NPINS=${#PINS[@]}
​
for ((;;)); do
	for i in ${!PINS[@]}; do
		# turn off previous pin
		if [ $i -eq 0 ]; then
			PREV=2
		else
			PREV=$((i-1))
		fi
		gpioset $CHIP ${PINS[$PREV]}=0
​
		# turn on current pin
		gpioset $CHIP ${PINS[$i]}=1
​
		# wait a sec
		sleep 1
	done
done
```

Second, run the script with root privileges: `sudo bash blinky.sh`

The output of your minicom session should resemble the following.

```console
$ *** Booting Zephyr OS build zephyr-v2.3.0-1435-g40c0ed940d71  ***
[00:00:00.011,932] <inf> net_config: Initializing network
[00:00:00.111,938] <inf> net_config: IPv6 address: fe80::6c42:bc1c:4b:1200
[00:00:00.112,121] <dbg> greybus_service.greybus_service_init: Greybus initializing..
[00:00:00.112,426] <dbg> greybus_transport_tcpip.gb_transport_backend_init: Greybus TCP/IP Transport initializing..
[00:00:00.112,579] <dbg> greybus_transport_tcpip.netsetup: created server socket 0 for cport 0
[00:00:00.112,579] <dbg> greybus_transport_tcpip.netsetup: setting socket options for socket 0
[00:00:00.112,609] <dbg> greybus_transport_tcpip.netsetup: binding socket 0 (cport 0) to port 4242
[00:00:00.112,640] <dbg> greybus_transport_tcpip.netsetup: listening on socket 0 (cport 0)
[00:00:00.112,823] <dbg> greybus_transport_tcpip.netsetup: created server socket 1 for cport 1
[00:00:00.112,823] <dbg> greybus_transport_tcpip.netsetup: setting socket options for socket 1
[00:00:00.112,854] <dbg> greybus_transport_tcpip.netsetup: binding socket 1 (cport 1) to port 4243
[00:00:00.112,854] <dbg> greybus_transport_tcpip.netsetup: listening on socket 1 (cport 1)
[00:00:00.113,037] <inf> net_config: IPv6 address: fe80::6c42:bc1c:4b:1200
[00:00:00.113,250] <dbg> greybus_transport_tcpip.netsetup: created server socket 2 for cport 2
[00:00:00.113,250] <dbg> greybus_transport_tcpip.netsetup: setting socket options for socket 2
[00:00:00.113,281] <dbg> greybus_transport_tcpip.netsetup: binding socket 2 (cport 2) to port 4244
[00:00:00.113,311] <dbg> greybus_transport_tcpip.netsetup: listening on socket 2 (cport 2)
[00:00:00.113,494] <dbg> greybus_transport_tcpip.netsetup: created server socket 3 for cport 3
[00:00:00.113,494] <dbg> greybus_transport_tcpip.netsetup: setting socket options for socket 3
[00:00:00.113,525] <dbg> greybus_transport_tcpip.netsetup: binding socket 3 (cport 3) to port 4245
[00:00:00.113,555] <dbg> greybus_transport_tcpip.netsetup: listening on socket 3 (cport 3)
[00:00:00.113,861] <inf> greybus_transport_tcpip: Greybus TCP/IP Transport initialized
[00:00:00.116,149] <inf> greybus_service: Greybus is active
[00:00:00.116,546] <dbg> greybus_transport_tcpip.accept_loop: calling poll
[00:45:08.397,399] <dbg> greybus_transport_tcpip.accept_loop: poll returned 1
[00:45:08.397,399] <dbg> greybus_transport_tcpip.accept_loop: socket 0 (cport 0) has traffic
[00:45:08.397,491] <dbg> greybus_transport_tcpip.accept_loop: accepted connection from [2001:db8::2]:39638 as fd 4
[00:45:08.397,491] <dbg> greybus_transport_tcpip.accept_loop: spawning client thread..
[00:45:08.397,735] <dbg> greybus_transport_tcpip.accept_loop: calling poll
[00:45:08.491,363] <dbg> greybus_transport_tcpip.accept_loop: poll returned 1
[00:45:08.491,363] <dbg> greybus_transport_tcpip.accept_loop: socket 3 (cport 3) has traffic
[00:45:08.491,455] <dbg> greybus_transport_tcpip.accept_loop: accepted connection from [2001:db8::2]:39890 as fd 5
[00:45:08.491,455] <dbg> greybus_transport_tcpip.accept_loop: spawning client thread..
[00:45:08.491,699] <dbg> greybus_transport_tcpip.accept_loop: calling poll
[00:45:08.620,056] <dbg> greybus_transport_tcpip.accept_loop: poll returned 1
[00:45:08.620,086] <dbg> greybus_transport_tcpip.accept_loop: socket 2 (cport 2) has traffic
[00:45:08.620,147] <dbg> greybus_transport_tcpip.accept_loop: accepted connection from [2001:db8::2]:42422 as fd 6
[00:45:08.620,147] <dbg> greybus_transport_tcpip.accept_loop: spawning client thread..
[00:45:08.620,422] <dbg> greybus_transport_tcpip.accept_loop: calling poll
[00:45:08.679,504] <dbg> greybus_transport_tcpip.accept_loop: poll returned 1
[00:45:08.679,534] <dbg> greybus_transport_tcpip.accept_loop: socket 1 (cport 1) has traffic
[00:45:08.679,595] <dbg> greybus_transport_tcpip.accept_loop: accepted connection from [2001:db8::2]:48286 as fd 7
[00:45:08.679,595] <dbg> greybus_transport_tcpip.accept_loop: spawning client thread..
[00:45:08.679,870] <dbg> greybus_transport_tcpip.accept_loop: calling poll
...
```
# Read I2C Registers

The SensorTag comes with an opt3001 ambient light sensor as well as an hdc2080 temperature & humidity sensor.

First, find which i2c device corresponds to the SensorTag:

```bash
ls -la /sys/bus/i2c/devices/* | grep "greybus"
lrwxrwxrwx 1 root root 0 Aug 15 11:24 /sys/bus/i2c/devices/i2c-8 -> ../../../devices/virtual/gb_nl/gn_nl/greybus1/1-2/1-2.2/1-2.2.2/gbphy2/i2c-8
```
On my machine, the i2c device node that Greybus creates is /dev/i2c-8.

Read the ID registers (at the i2c register address 0x7e) of the opt3001 sensor (at i2c bus address 0x44) as shown below:

```bash
i2cget -y 8 0x44 0x7e w
0x4954
```

Read the ID registers (at the i2c register address 0xfc) of the hdc2080 sensor (at i2c bus address 0x41) as shown below:

```bash
i2cget -y 8 0x41 0xfc w 
0x5449
```

# Conclusion
The blinking LED can and poking i2c registers can be a somewhat anticlimactic, but hopefully it illustrates the potential for Greybus as an IoT application layer protocol.

What is nice about this demo, is that we're using Device Tree to describe our Greybus Peripheral declaratively, they Greybus Manifest is automatically generated, and the Greybus Service is automatically started in Zephyr.

In other words, all that is required to replicate this for other IoT devices is simply an appropriate Device Tree overlay file.

The proof-of-concept involving Linux, Zephyr, and IEEE 802.15.4 was actually fairly straight forward and was accomplished with mostly already-upstream source.

For Greybus in Zephyr, there is still a considerable amount of integration work to be done, including
* converting the fork to a proper Zephyr module
* adding security and authentication
* automatic detection, joining, and rejoining of devices

Thanks for reading, and we hope you've enjoyed this tutorial.