# Linux to Zephyr TCP Communication over IEEE 802.15.4 and 6LowPAN
This document describes, in some detail, the steps required to establish a reliable TCP commmunication channel between
a [Linux](https://en.wikipedia.org/wiki/Linux) workstation and [Zephyr](https://zephyrproject.org) device over [IEEE 802.15.4](https://en.wikipedia.org/wiki/IEEE_802.15.4) and [IPv6](https://en.wikipedia.org/wiki/IPv6) 
(via [6LowPAN](https://en.wikipedia.org/wiki/6LoWPAN)).

# Hardware Requirements
* a Linux workstation running [Ubuntu Bionic](https://releases.ubuntu.com/18.04.4)
  * Only x86_64 is supported at this time
* a board that is supported by Zephyr with support for IEEE 802.15.4
  * In this example, we use the [cc1352r1_launchxl](https://docs.zephyrproject.org/latest/boards/arm/cc1352r1_launchxl/doc/index.html)
  * Available for purchase directly from [Texas Instruments](http://www.ti.com/tool/LAUNCHXL-CC1352R1) or a distributor
  * Please ensure that you purchase a device with [Revision E Silicon](http://www.ti.com/lit/er/swrz077b/swrz077b.pdf) to avoid silicon errata.
  * Also ensure that all jumpers are connected `GND, 5V, 3V3, RXD<<, TXD>>, RST, TMS, TCK, TDO, TDI, SW0`
* a USB IEEE 802.15.4 adapter
  * In this example, we use the [atusb](http://downloads.qi-hardware.com/people/werner/wpan/web)
  * Available for purchase from [sysmocom](http://shop.sysmocom.de/products/atusb)
  * This part is [OSHW](https://www.oshwa.org/) (i.e. all CAD files and firmware source is available) for those who choose to create their own.

# Prerequisites
* Zephyr environment is set up according to the [Getting Started Guide](https://docs.zephyrproject.org/latest/getting_started/index.html)
  * Please use the Zephyr SDK when installing a toolchain above
* [Zephyr SDK](https://docs.zephyrproject.org/latest/getting_started/index.html#install-a-toolchain) is installed at ~/zephyr-sdk-0.11.2
* Zephyr board is connected via USB
* IEEE 802.15.4 Adapter is connected via USB

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
## Build and Flash Zephyr
Here, we will build and flash the Zephyr [echo_server sample](https://docs.zephyrproject.org/latest/samples/net/sockets/echo_server/README.html) to our device.

1. Open a separate terminal window (`Ctrl+Shift+N`) or simply create a new tab in your existing terminal (`Ctrl+Shift+T`) so that you can see both or quickly switch between `minicom` and the shell.
1. Now in the shell, change to the `zephyrproject/zephyr` directory
1. Edit the file `~/.zephyrrc` and place the following text inside of it
    ```
    export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
    export ZEPHYR_SDK_INSTALL_DIR=~/zephyr-sdk-0.11.2
    export BOARD=cc1352r1_launchxl
    export ZEPHYR_PROJECT=samples/net/sockets/echo_server
    ```
1. Edit the file `samples/net/sockets/echo_server/prj.conf` and apply the following change.
    ```diff
    diff --git a/samples/net/sockets/echo_server/overlay-802154.conf b/samples/net/sockets/echo_server/overlay-802154.conf
    index fa9e680027..19330bee9b 100644
    --- a/samples/net/sockets/echo_server/overlay-802154.conf
    +++ b/samples/net/sockets/echo_server/overlay-802154.conf
    @@ -1,7 +1,7 @@
     CONFIG_BT=n
     
     # Disable TCP and IPv4 (TCP disabled to avoid heavy traffic)
    -CONFIG_NET_TCP=n
    +CONFIG_NET_TCP=y
     CONFIG_NET_IPV4=n
     
     CONFIG_NET_CONFIG_NEED_IPV6=y
    ```
1. Set up the required Zephyr environment variables via `source zephyr-env.sh`
1. Build the project
    ```
    west build ${ZEPHYR_PROJECT} -- -DCONF_FILE="prj.conf overlay-802154.conf"
    ```
1. Ensure that the last part of the build process looks somewhat like this:
    ```console
    ...
    [191/196] Linking C executable zephyr/zephyr_prebuilt.elf
    Memory region         Used Size  Region Size  %age Used
               FLASH:      132688 B     360360 B     36.82%
          FLASH_CCFG:          88 B         88 B    100.00%
                SRAM:       61528 B        80 KB     75.11%
            IDT_LIST:         168 B         2 KB      8.20%
    [196/196] Linking C executable zephyr/zephyr.elf
    ```
1. Flash the firmware to your device using `west flash`

## The Zephyr Shell

After flashing, you should observe the something matching the following output in `minicom`.
```
*** Booting Zephyr OS build v2.3.0-rc1-391-g3852e0812618  ***
[00:00:00.011,199] <inf> net_config: Initializing network
[00:00:00.111,206] <inf> net_config: IPv6 address: fe80::cf99:a11c:4b:1200
[00:00:00.111,297] <inf> net_config: IPv6 address: fe80::cf99:a11c:4b:1200
[00:00:03.111,663] <inf> net_echo_server_sample: Run echo server
[00:00:03.111,724] <inf> net_echo_server_sample: Network connected
[00:00:03.111,755] <inf> net_echo_server_sample: Starting...
[00:00:03.111,907] <inf> net_echo_server_sample: Waiting for TCP connection on port 4242 (IPv6)...
[00:00:03.112,060] <inf> net_echo_server_sample: Waiting for UDP packets on port 4242 (IPv6)...
uart:~$ 
```

The line beginning with `***` is the Zephyr boot banner.

Lines beginning with a timestamp of the form `[H:m:s:us]` are Zephyr kernel messages.

Lines beginning with `uart:~$ ` indicates that the Zephyr shell is prompting you to enter a command.

From the informational messages shown, we observe the following.
* Zephyr is configured with the following [link-local IPv6 address](https://en.wikipedia.org/wiki/Link-local_address#IPv6) `fe80::cf99:a11c:4b:1200`
* It is listening for (both) TCP and UDP traffic on port 4242

However, what the log messages do *not* show (which will come into play later), are 2 critical pieces of information:
1. the actual RF Channel
    IEEE 802.15.4 devices are only able to communicate with each other if (as you may have guessed), they are using
    the same frequency to transmit and recieve data. This information is part of the Physical Layer.
1. the [PAN identifier](https://www.silabs.com/community/wireless/proprietary/knowledge-base.entry.html/2019/10/04/connect_tutorial6-ieee802154addressing-rapc)
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
24: wpan0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 123 qdisc fq_codel state UNKNOWN group default qlen 300
    link/ieee802.15.4 3e:7d:90:4d:8f:00:76:a2 brd ff:ff:ff:ff:ff:ff:ff:ff
```
But wait, that is not an IP address! It's the hardware address of the 802.15.4 device. So, in order to associate it with an IP address, we need to run a couple of other commands (thanks to [cakelab.org](http://wpan.cakelab.org/)).

## Set the 802.15.4 Physical and Link-Layer Parameters
1. First, get the phy number for the `wpan0` device
    ```console
    $ iwpan list 
    wpan_phy phy15
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
    sudo iwpan phy phy15 set channel 0 26
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
following when we run `ip a show wpan0`. 
```console
25: lowpan0@wpan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1280 qdisc noqueue state UNKNOWN group default qlen 1000
    link/6lowpan 3e:7d:90:4d:8f:00:76:a2 brd ff:ff:ff:ff:ff:ff:ff:ff
    inet6 fe80::3c7d:904d:8f00:76a2/64 scope link 
       valid_lft forever preferred_lft forever
```

# Ping Pong
## Broadcast Ping

Now, perform a broadcast ping to see what else is listening on `lowpan0`.
```console
$ ping6 -I lowpan0 ff02::1
PING ff02::1(ff02::1) from fe80::3c7d:904d:8f00:76a2%lowpan0 lowpan0: 56 data bytes
64 bytes from fe80::3c7d:904d:8f00:76a2%lowpan0: icmp_seq=1 ttl=64 time=0.090 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=1 ttl=64 time=20.5 ms (DUP!)
64 bytes from fe80::3c7d:904d:8f00:76a2%lowpan0: icmp_seq=2 ttl=64 time=0.070 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=2 ttl=64 time=26.5 ms (DUP!)
64 bytes from fe80::3c7d:904d:8f00:76a2%lowpan0: icmp_seq=3 ttl=64 time=0.133 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=3 ttl=64 time=18.0 ms (DUP!)
```

Yay! We have pinged (pung?) the Zephyr device over IEEE 802.15.4 using 6LowPAN!

## Ping Zephyr
We can ping the Zephyr device directly without a broadcast ping too, of course.
```console
$ ping6 -I lowpan0 fe80::cf99:a11c:4b:1200
PING fe80::cf99:a11c:4b:1200(fe80::cf99:a11c:4b:1200) from fe80::3c7d:904d:8f00:76a2%lowpan0 lowpan0: 56 data bytes
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=1 ttl=64 time=10.9 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=2 ttl=64 time=18.4 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=3 ttl=64 time=9.74 ms
64 bytes from fe80::cf99:a11c:4b:1200%lowpan0: icmp_seq=4 ttl=64 time=17.4 ms
```
## Ping Linux
Similarly, we can ping the Linux host from the Zephyr shell.
```console
uart:~$ net ping --help
ping - Ping a network host.
Subcommands:
  --help  :'net ping [-c count] [-i interval ms] <host>' Send ICMPv4 or ICMPv6
           Echo-Request to a network host.
uart:~$ net ping -c 5 fe80::3c7d:904d:8f00:76a2
PING fe80::3c7d:904d:8f00:76a2
8 bytes from fe80::3c7d:904d:8f00:76a2 to fe80::cf99:a11c:4b:1200: icmp_seq=0 ttl=64 rssi=158 time=13 ms
8 bytes from fe80::3c7d:904d:8f00:76a2 to fe80::cf99:a11c:4b:1200: icmp_seq=1 ttl=64 rssi=155 time=9 ms
8 bytes from fe80::3c7d:904d:8f00:76a2 to fe80::cf99:a11c:4b:1200: icmp_seq=2 ttl=64 rssi=158 time=5 ms
8 bytes from fe80::3c7d:904d:8f00:76a2 to fe80::cf99:a11c:4b:1200: icmp_seq=3 ttl=64 rssi=161 time=10 ms
8 bytes from fe80::3c7d:904d:8f00:76a2 to fe80::cf99:a11c:4b:1200: icmp_seq=4 ttl=64 rssi=158 time=10 ms
```

# TCP (Telnet All the Things!)

To finish things up, we'll demonstrate the echo_server application in Zephyr as we originally set out to.

From Linux, run 
```
$ telnet fe80::cf99:a11c:4b:1200%lowpan0 4242
Trying fe80::cf99:a11c:4b:1200%lowpan0...
Connected to fe80::cf99:a11c:4b:1200%lowpan0.
Escape character is '^]'.
Hello, Zephyr world!
Hello, Zephyr world!
^]
telnet> quit
Connection closed.
```

Note, to escape a telnet session, press `Ctrl+Shift+']'`.

# Final Notes

So far, we have been using IPv6 Link-Local addressing. However, the Zephyr application is configured to use a statically configured IPv6 address as well which is, namely `2001:db8::1`.

If we add a similar static IPv6 address to our Linux 802.15.4 network interface, `lowpan0`, then we should expect that the echo_server example should work equally well.

In Linux, run the following
```console
sudo ip -6 addr add 2001:db8::2/64 dev lowpan0
```
We can verify that the address has been set by examining the `lowpan0` network interface again.
```
ip addr show lowpan0
25: lowpan0@wpan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1280 qdisc noqueue state UNKNOWN group default qlen 1000
    link/6lowpan 3e:7d:90:4d:8f:00:76:a2 brd ff:ff:ff:ff:ff:ff:ff:ff
    inet6 2001:db8::2/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fe80::3c7d:904d:8f00:76a2/64 scope link 
       valid_lft forever preferred_lft forever
```

Lastly, `telnet` to the statically configured IPv6 address of the Zephyr device.
```console
$ telnet 2001:db8::1 4242
Trying 2001:db8::1...
Connected to 2001:db8::1.
Escape character is '^]'.
What is the answer to life the universe and everything?        
42
```
Just kidding. It just echo'ed the same question back. This is a microcontroller, not an [enormous supercomputer named Deep Thought](https://en.wikipedia.org/wiki/42_(number)#The_Hitchhiker's_Guide_to_the_Galaxy).

# Conclusion
That's it! We hope you've enjoyed this small tutorial on TCP networking using IEEE 802.15.4 and 6LowPAN. Time to get busy writing socket applications!