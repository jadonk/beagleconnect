# LED definition

These definitions are proposed with the mindset of giving end-users high-level functional
status indication of the devices and nodes. It seeks to avoid having the status of any
one LED being required to interpret another, which has the undesirable effect of limiting
the amount of information that can be conveyed, but should simplify interpretation.

Single letter abbreviations are provided in case we can put these on a silkscreen on the
side of the case.

## Positions

#TODO: - I need to determine for sure where each LED is on the board and make it clear in this document.

## Functions

<table>
 <thead>
  <tr>
   <td>LED</td>
   <td>Signal</td>
   <td>Status</td>
   <td>Indication</td>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td rowspan=2>CHG (Charging)</td>
   <td rowspan=2>CHG (no S/W control)</td>
   <td>On</td>
   <td>Charger active</td>
  </tr>
  <tr>
   <td>Off</td>
   <td>Charger not active</td>
  </tr>
  <tr>
   <td rowspan=4>LNK (Link)</td>
   <td rowspan=4>2.4G (DIO_18 on CC1352)</td>
   <td>On</td>
   <td>Radio RX within timeout</td>
  </tr>
  <tr>
   <td>Fast blink</td>
   <td>Radio active</td>
  </tr>
  <tr>
   <td>Off</td>
   <td>Radio RX inactive (timeout)</td>
  </tr>
  <tr>
   <td>Slow blink</td>
   <td>Radio error</td>
  </tr>
  <tr>
   <td rowspan=4>USB (USB)</td>
   <td rowspan=4>900M (P6.1 on MSP430)</td>
   <td>On</td>
   <td>Device in <i>gateway</i> mode</td>
  </tr>
  <tr>
   <td>Fast blink</td>
   <td>USB active</td>
  </tr>
  <tr>
   <td>Off</td>
   <td>Device in <i>node</i> mode</td>
  </tr>
  <tr>
   <td>Slow blink</td>
   <td>Seeking USB (<i>gateway</i>) connection</td>
  </tr>
  <tr>
   <td rowspan=2>PWR (Power)</td>
   <td rowspan=2>PWR (no S/W control)</td>
   <td>On</td>
   <td>Device powered</td>
  </tr>
  <tr>
   <td>Off</td>
   <td>Device not powered</td>
  </tr>
  <tr>
   <td rowspan=6>MB1 (mikroBUS 1)</td>
   <td rowspan=6>LED1 (P6.2 on MSP430)</td>
   <td>On</td>
   <td>Identified and connected</td>
  </tr>
  <tr>
   <td>Fast blink (w/o 2)</td>
   <td>Active</td>
  </tr>
  <tr>
   <td>Fast blink (w/ 2)</td>
   <td>Internal sensor active</td>
  </tr>
  <tr>
   <td>Off</td>
   <td>Inactive</td>
  </tr>
  <tr>
   <td>Slow blink (w/o 2)</td>
   <td>Identified, but not connected</td>
  </tr>
  <tr>
   <td>Slow blink (w/ 2)</td>
   <td>Seeking Greybus connection</td>
  </tr>
  <tr>
   <td rowspan=6>MB2 (mikroBUS 2)</td>
   <td rowspan=6>LED2 (P6.3 on MSP430)</td>
   <td>On</td>
   <td>Identified and connected</td>
  </tr>
  <tr>
   <td>Fast blink (w/o 1)</td>
   <td>Active</td>
  </tr>
  <tr>
   <td>Fast blink (w/ 1)</td>
   <td>Internal sensor active</td>
  </tr>
  <tr>
   <td>Off</td>
   <td>Inactive</td>
  </tr>
  <tr>
   <td>Slow blink (w/o 1)</td>
   <td>Identified, but not connected</td>
  </tr>
  <tr>
   <td>Slow blink (w/ 1)</td>
   <td>Seeking Greybus connection</td>
  </tr>
 </tbody>
</table>

## Modes

<table>
 <thead>
  <tr>
   <td>Mode/firmware</td>
   <td>Submode</td>
   <td>USB LED (U)</td>
   <td>MikroBUS LEDs (1/2)</td>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td rowspan=1>Sensortest node</td>
   <td>-</td>
   <td>off</td>
   <td>off</td>
  </tr>
  <tr>
   <td rowspan=4>Greybus node</td>
   <td>searching</td>
   <td rowspan=3>off</td>
   <td>slow blink</td>
  </tr>
  <tr>
   <td>searching</td>
   <td rowspan=3>connected</td>
   <td>off</td>
  </tr>


| Mode/firmware   | USB LED                                 | MikroBUS 1/2 LEDs                       |
| --------------- | --------------------------------------- | --------------------------------------- |
| Sensortest node | off                                     | off                                     |
| Greybus node    | off                                     | slow blink, fast blink, or on (not off) |
| Gateway         | slow blink, fast blink, or on (not off) | off                                     |

## Implementation

### Link

#### CC1352
* We've got a hook for TX toggle at the antenna switch. A global variable can remember if
  we should leave it on or off.
* I need to look for where we have RX at the level of valid IEEE802.15.4 packets on the
  SubG radio. I think we can set the flag there, but probably need a mutex.

### USB

#### MSP430
* A global flag to reflect the LED mode
* Set the LED if USB connected and HDLC connection established with _gateway_ firmware
* Toggle the LED status with short pulses based on getting or sending USB traffic
* Toggle the LED slow if USB is connected, but not in HDLC mode (passthrough or searching for HDLC)

### 1/2

TBD

