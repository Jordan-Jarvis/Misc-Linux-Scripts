#!/bin/bash
barrier &
IPADDR=$(ip addr show enp4s0)
IPADDR2="`echo "$IPADDR" | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`"
echo $IPADDR2
ssh jordan@fe80::8416:6564:9960:9431%enp4s0 "DISPLAY=:0 barrierc -f --enable-crypto $IPADDR2"
