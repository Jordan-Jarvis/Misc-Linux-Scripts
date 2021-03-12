#!/bin/bash
# This script opens Barrier (mouse and keyboard sharing software) on the host machine. It will ssh to the ipv6 address as it is basically static, get the ipv4 address, and start the client connecting to the server with the ipv4 address. I did this to fix changing my IP manually any time the host IP changed. 
barrier &
IPADDR=$(ip addr show enp4s0)
IPADDR2="`echo "$IPADDR" | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`"
echo $IPADDR2
ssh jordan@fe80::8416:6564:9960:9431%enp4s0 "DISPLAY=:0 barrierc -f --enable-crypto $IPADDR2"
