#!/bin/bash -xv
#ping6 -I lowpan0 2001:db8::1 -c 5
ping6 -I lowpan0 ff02::1 -c 5
