#!/usr/bin/env python
import socket
import sys
import struct
import datetime
import curses
import operator

sock = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
sock.bind(('', 9999))
sock.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_MULTICAST_LOOP, True)
mreq = struct.pack("16s15s".encode('utf-8'), socket.inet_pton(socket.AF_INET6, "ff02::1"), (chr(0) * 16).encode('utf-8'))
sock.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_JOIN_GROUP, mreq)

node = {}

def main(stdscr):
  while True:
    data, sender = sock.recvfrom(1024)
    node[sender[0]] = datetime.datetime.now()
    stdscr.clear()
    s_node = sorted(node.items(), key=operator.itemgetter(1), reverse=True)
    n = datetime.datetime.now()
    for i in xrange(len(s_node)):
      s = "%3d - %s" % (i+1, str(s_node[i][0]))
      t = str((n - s_node[i][1]).total_seconds())
      #print(t)
      stdscr.addstr(i, 0, s)
      stdscr.addstr(i, 40, t)
    stdscr.refresh()

curses.wrapper(main)
