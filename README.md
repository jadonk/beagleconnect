# BeagleConnect
The purpose of BeagleConnect is to eliminate the need to write software to connect to a massive library of [sensors](https://en.wikipedia.org/wiki/Sensor), [actuators](https://en.wikipedia.org/wiki/Actuator) and [indicators](https://en.wikipedia.org/wiki/Indicator_(distance_amplifying_instrument)). These are the tools used to automate things in [mechatronics](https://en.wikipedia.org/wiki/Mechatronics) and [IoT](https://en.wikipedia.org/wiki/Internet_of_things).

BeagleConnect solves:
* The need to write software to add a large set of diverse devices to your system,
* The need to maintain the software with security updates,
* The need to rapidly prototype using off-the-shelf software and hardware without wiring,
* The need to connect to devices using long-range, low-power wireless, and
* The need to produce high-volume custom hardware cost-optimized for your requirements.

The minimally viable BeagleConnect development release:
* Supports at least 100 mikroBUS-based Click boards from Mikroelectronika,
* Works with BLE-enabled Linux computers at 2.4GHz,
* Works on long-range sub-GHz at 500m with data rates of 1kbps, and
* Comprises of low-cost BeagleBoard.org Linux SBC, a BeagleConnect gateway, and at least 10 BeagleConnect device nodes each supporting 2 add-on devices.

A wireless BeagleConnect board for adding a new device node is targeted to cost under US$10.

Future releases will be collaborated with the community, evolve dynamically, and contain additional functionality. The goal is to support over 500 add-on devices within the first year after the development release.

_Aside_: The term BeagleConnect refers to a particular board as well as a family of boards, a collection of Linux kernel drivers, microcontroller firmware, communication protocol, and system-level integration to automation software tools. More specific terms will be applied in the architecture details. The term is meant to represent the experience to be introduced to users through the initial BeagleConnect board.

## BeagleConnect wireless board prototype rev B
![BeagleConnect rev B prototype](https://github.com/jadonk/beagleconnect/blob/master/docs/MVIMG_20200410_095337.jpg?raw=true)

# What is new?
BeagleConnect solves IoT in a different and better way than any previous solution.

## The device interface software is already done
BeagleConnect uses the collaboratively developed Linux kernel to contain the intelligence required to speak to these devices (sensors, actuators, and indicators), rather than relying on writing code on a microcontroller specific to these devices. Some existing solutions rely on large libraries of microcontroller code, but the integration of communications, maintenance of the library with a limited set of developer resources and other constraints to be explained later make those other solutions less suitable for rapid prototyping than BeagleConnect.

Linux presents these devices abstractly in ways that are self-descriptive. Add an accelerometer to the system and you are automatically fed a stream of force values in standard units. Add a temperature sensor and you get it back in standard units again. Same for sensing magnetism, proximity, color, light, frequency, orientation, or multitudes of other inputs. Indicators, such as LEDs and displays, are similarly abstracted with a few other kernel subsystems and more advanced actuators with and without feedback control are in the process of being developed and standardized. In places where proper Linux kernel drivers exist, no new specialized code needs to be created for the devices.

*Bottom line*: For hundreds of devices, users won't have to write a single line of code to add them their systems. The automation code they do write can be extremely simple, done with graphical tools or in any language they want. Maintenance of the code is centralized in a small reusable set of microcontroller firmware and the Linux kernel, which is highly peer reviewed under a [highly-regarded governance model](https://wiki.p2pfoundation.net/Linux_-_Governance).

## On-going maintenance
Because there isn't code specific to any given network-of-devices configuration, we can all leverage the same software code base. This means that when someone fixes an issue in either BeagleConnect firmware or the Linux kernel, you benefit from the fixes. The source for BeagleConnect firmware is also submitted to the [Zephyr Project](https://www.zephyrproject.org/) upstream, further increasing the user base. Additionally, we will maintain stable branches of the software and provide mechanisms for updating firmware on BeagleConnect hardware. With a single, relatively small firmware load, the potential for bugs is kept low. With large user base, the potential for discovering and resolving bugs is high.

## Rapid prototyping without wiring
BeagleConnect utilizes the [mikroBUS standard](https://elinux.org/Mikrobus). The mikroBUS standard interface is flexible enough for almost any typical sensor or indicator with hundreds of devices available.

## Long-range, low-power wireless
BeagleConnect wireless hardware is built around a [TI CC1352](http://www.ti.com/product/CC1352R) with TODO benefits.

## Full customization possible
BeagleConnect utilizes [open source hardware](https://www.oshwa.org/definition/) and [open source software](https://en.wikipedia.org/wiki/Open-source_software), making it possible to optimize hardware and software implementations and sourcing to meet end-product requirements. BeagleConnect is meant to enable rapid-prototyping and not to necessarily satisfy any particular end-product's requirements, but with full considerations for go-to-market needs.

BeagleConnect is:
* Available for at least 10 years,
* Built with fully open source software with submissions to mainline Linux and Zephyr repositories to aide in support and porting,
* Built with fully open source and non-restrictive hardware design including schematic, bill-of-materials, layout, and manufacturing files (with only the BeagleBoard.org logo removed due to licensing restrictions of our brand),
* Built with parts where at least a compatible part is available from worldwide distributors in any quantity,
* Built with design and manufacturing partners able to help scale derivative designs,
* Based on a security model using public/private keypairs that can be replaced to secure your own network, and
* Fully FCC/CE certified.

# Usage and development

## BeagleConnect user experience

### Enable a Linux host with BeagleConnect
![Provisioning Step 1](https://github.com/jadonk/beagleconnect/blob/master/docs/ProvStep1.PNG?raw=true)
Log into a host system running Linux that is BeagleConnect enabled. Enable a Linux host with BeagleConnect by plugging a BeagleConnect board into it's USB port. You'll also want to have another BeagleConnect board with a sensor, actuator or indicator device on it.

TODO: Currently the host is shown to be a PocketBeagle with a cape, but should likely be a different SBC with a BeagleConnect board connected over USB.

TODO: Currently the device is shown to be a Sensortag, but should likely be shown as a BeagleConnect with a Click Board device on it and a battery.

### Connect host and device
![Provisioning Step 2](https://github.com/jadonk/beagleconnect/blob/master/docs/ProvStep2.PNG?raw=true)
Initiate a connection between the host and devices by pressing the discovery button(s).

### Device data shows up as files
![Provisioning Step 3](https://github.com/jadonk/beagleconnect/blob/master/docs/ProvStep3.PNG?raw=true)
New streams of self-describing data show up on the host system using native device drivers.

## Components
* Host-side: BeagleConnect board connects a CC1352 to a Beagle or other Linux host over USB to serial
   * Provides long-range, low-power wireless communications
* Device-side: BeagleConnect board with a CC1352 is powered by a battery (coin cell or JST connector) or USB connector
   * Provides 2 mikroBUS connectors for connecting any of hundreds of [Click Board](https://bbb.io/click) mikroBUS add-on devices
* Standard firmware on the host-side and target-side CC1352s transport the standard busses
   * Paired with a Linux kernel driver
   * Provides new Linux host controllers for SPI, I2C, UART, PWM, ADC, and GPIO with interrupts
* Two-step provisioning
   * Enter provisioning mode by pressing the button on the host-side BeagleConnect
   * Press the button on any powered device-side BeagleConnect to add it to the network
      * The device interfaces get exposed to the host via Greybus BRIDGED_PHY protocol
      * The I2C bus is probed for a an identifier EEPROM and appropriate device drivers are loaded on the host
      * Unsupported Click Boards connected are exposed via userspace drivers on the host for development

### What's different
* No microcontroller code development is required by users
* Userspace drivers make rapid prototyping really easy
* Kernel drivers makes the support code collaborative parts of the Linux kernel, rather than cut-and-paste

## Development platform
* Linux machine
* 2x [CC1352R Launchpad](http://www.ti.com/tool/launchxl-cc1352r1)
* [Click BoosterPack 2](https://www.mikroe.com/click-booster-pack-2)

# Technical approach
![Software Proposition](https://github.com/jadonk/beagleconnect/blob/master/docs/SoftwareProp.PNG?raw=true)
BeagleConnect uses Greybus and updated Click Boards with identifiers to eliminate the need to add manually configure devices added onto the Linux system.

## High-level
* For Linux nerds: Think of BeagleConnect as [6LoWPAN](https://en.wikipedia.org/wiki/6LoWPAN) over [802.15.4](https://en.wikipedia.org/wiki/IEEE_802.15.4)-based [Greybus](https://kernel-recipes.org/en/2015/talks/an-introduction-to-greybus/) (instead of Unipro as used by Project Ara), where every BeagleConnect board shows up as new SPI, I2C, UART, PWM, ADC, and GPIO controllers that can now be probed to load drivers for the sensors or whatever is connected to them. (Proof of concept of Greybus over TCP/IP: https://www.youtube.com/watch?v=7H50pv-4YXw)
* For MCU folks: Think of BeagleConnect as a [Firmata](https://github.com/firmata/protocol)-style firmware load that exposes the interfaces for remote access over a secured wireless network. However, instead of using host software that knows how to speak the Firmata protocol, the Linux kernel speaks the slightly similar Greybus protocol to the MCU and exposes the device generically to users using a Linux kernel driver. Further, the Greybus protocol is spoken over [6LoWPAN](https://en.wikipedia.org/wiki/6LoWPAN) on [802.15.4](https://en.wikipedia.org/wiki/IEEE_802.15.4).

## Software architecture
* 802.15.4 provides the 

## TODO items
* Linux kernel driver
* Provisioning
   * Kconfig and what-not for adding a new BeagleDust to the network
   * Kconfig and what-not for configuring Clicks connected to BeagleDust
* Firmware for host CC13x
* Firmware for device CC13x
* Click Board drivers and device tree formatted metadata for 100 or so Click Boards
* Click Board plug-ins for node-red for the same 100 or so Click Boards
* BeagleDust System Reference Manual and FAQs

## Associated pre-work
* Click Board support for Node-RED can be executed with native connections on PocketBeagle+TechLab and BeagleBone Black with mikroBUS Cape
   * Device tree fragments and driver updates can be provided via https://bbb.io/click
* The Kconfig style provisioning can be implemented for those solutions, which will require a reboot. We need to centralize edits to /boot/uEnv.txt to be programmatic. As I think through this, I don't think BeagleConnect is impacted, because the Greybus-style discovery along with Click EEPROMS will eliminate any need to edit /boot/uEnv.txt.

## User experience concerns
* Make sure no reboots are required
* Plugging BeagleConnect into host should trigger host configuration
* Click EEPROMs should trigger loading whatever drivers are needed and provisioning should load any new drivers
* Userspace (spidev, etc.) drivers should unload cleanly when 2nd phase provisioning is completed

