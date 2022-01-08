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

### C (Charging)

On
: Attached battery is being charged

Off
: Charger is not active

### L (Link)

On
: IEEE802.15.4 SubGHz connection established (RX occurred recently)

Fast blink
: IEEE802.15.4 SubGHz data TX or RX

Off
: IEEE802.15.4 SubGHz traffic not seen for some timeout period

Slow blink
: IEEE802.15.4 SubGHz connection error detected

### H (Gateway/Host)

On
: Device is in _gateway_ mode

Fast blink
: USB UART data traffic over MSP430

Off
: Device is in _node_ mode

Slow blink
: MSP430 is looking for a _gateway_ connection (USB active), but the CC1352 has not set the MSP430 clearly in _gateway_ or _node_ mode

### P (Power)

On
: Device is powered

Off
: Device is not powered

### 1 (mikroBUS 1)

On
: mikroBUS 1 add-on identified and Greybus connection established

Fast blink (2 not blinking)
: mikroBUS 1 add-on interface traffic (Greybus or other)

Fast blink (2 blinks at same time)
: On-board sensor interface traffic (Greybus or other)

Off
: No sensor identified and not seeking Greybus connection

Slow blink (2 not blinking)
: Sensor identified in mikroBUS 1 socket and seeking a Greybus connection

Slow blink (2 blinks at same time)
: Seeking a Greybus connection with or without identifying any external sensor

### 2 (mikroBUS 2)

On
: mikroBUS 2 add-on identified and Greybus connection established

Fast blink (1 not blinking)
: mikroBUS 2 add-on interface traffic (Greybus or other)

Fast blink (1 blinks at same time)
: On-board sensor interface traffic (Greybus or other)

Off
: No sensor identified and not seeking Greybus connection

Slow blink (1 not blinking)
: Sensor identified in mikroBUS 2 socket and seeking a Greybus connection

Slow blink (1 blinks at same time)
: Seeking a Greybus connection with or without identifying any external sensor

