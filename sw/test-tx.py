#!/usr/bin/env python
import socket
import sys
import struct
import time
import os

#if os.geteuid()==0:
#  print "Running as root."
#else:
#  print "User is not root."

addrinfo = socket.getaddrinfo("ff02::1", None)[0]
s = socket.socket(addrinfo[0], socket.SOCK_DGRAM)
s.setsockopt(socket.SOL_SOCKET, 25, 'lowpan0')
s.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_MULTICAST_LOOP, True)


while True:
    data = repr(time.time())
    s.sendto(data + '\0', (addrinfo[4][0], 9999))
    time.sleep(1)

