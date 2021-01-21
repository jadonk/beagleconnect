#!/bin/sh -xv
IFLP=`ifconfig | grep lowpan`
ip link set wpan0 down
iwpan phy phy0 set channel 0 26
iwpan dev wpan0 set pan_id 0xabcd
if [ "$IFLP" == "" ]; then
  ip link add link wpan0 name lowpan0 type lowpan
  ip link set lowpan0 up
fi
ip link set wpan0 up
ip -6 addr add 2001:db8::2/64 dev lowpan0
sleep 1

killall -9 gbridge
sleep 1

ping6 -I lowpan0 2001:db8::1 -c 5
sleep 1

gbridge > /var/log/gbridge &

sleep 5
while true; do gpioset 0 6=1; gpioset 0 6=0; sleep 1; done &
