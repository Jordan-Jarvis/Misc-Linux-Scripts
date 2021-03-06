#!/bin/bash
# Creates a dummy camera on a host machine, then sets up a stream from a client machine (laptop camera to desktop pc, combine with barrier and it is a great experience) to a desktop (host) machine. Uses IPv6 address to get around non-static networks.
sudo modprobe v4l2loopback exclusive_caps=1 card_label="MyLaptopCam:MyLaptopCam"
ssh jordan@fe80::8416:6564:9960:9431%enp4s0 "ffmpeg -i /dev/video0 -codec copy -f matroska - | nc -l 9999" &
IPADDR=$(ssh jordan@fe80::8416:6564:9960:9431%enp4s0 "ip addr show enx8cec4b0d2d63")
IPADDR2="`echo "$IPADDR" | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`"
echo $IPADDR2
nc "$IPADDR2" 9999 | ffmpeg -i /dev/stdin -codec copy -f v4l2 /dev/video0
