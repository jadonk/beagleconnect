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

### S (Sensor)

On
: TBD

Fast blink
: Sensor traffic

Off
: TBD

Slow blink
: Sensor error

### G (Greybus)

On
: Greybus connection is active

Fast blink
: Greybus traffic

Off
: Greybus connection is inactive

Slow blink
: Greybus connection being attempted, but not completed

