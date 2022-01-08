# LED definition

These definitions are proposed with the mindset of giving end-users high-level functional
status indication of the devices and nodes. It seeks to avoid having the status of any
one LED being required to interpret another, which has the undesirable effect of limiting
the amount of information that can be conveyed, but should simplify interpretation.

Single letter abbreviations are provided in case we can put these on a silkscreen on the
side of the case.

## Positions

TBD - I need to determine for sure where each LED is on the board and make it clear in this document.

## Functions

<table>
 <thead>
  <tr>
   <td>LED</td>
   <td>Status</td>
   <td>Indication</td>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td rowspan=2>C (Charging)</td>
   <td>On</td>
   <td>Charger active</td>
  </tr>
  <tr>
   <td>Off</td>
   <td>Charger not active</td>
  </tr>
  <tr>
   <td rowspan=4>L (Link)</td>
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
   <td rowspan=4>U (USB)</td>
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
   <td rowspan=2>P (Power)</td>
   <td>On</td>
   <td>Device powered</td>
  </tr>
  <tr>
   <td>Off</td>
   <td>Device not powered</td>
  </tr>
  <tr>
   <td rowspan=6>1 (mikroBUS 1)</td>
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
   <td rowspan=6>2 (mikroBUS 2)</td>
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

