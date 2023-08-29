#!/bin/bash

echo "WPA3 password cracking tool."


read -p "Please enter your WLAN interface: " wlan_interface


read -p "Please enter the BSSID of the router: " bssid

attempt=1
echo "Starting..."
echo "Stop Script with STRG + C"

spinner="/-\\|"
while true; do
    if [ -f password_found.txt ]; then
        echo -e "\nPassword found!"
        echo "Current password is being tested:"
        echo "##############################"
        echo "#   ${current_password}   #"
        echo "##############################"
        cat password_found.txt
        exit 0
    fi
    
    if [ $attempt -eq 3 ]; then
        sleep 0.12
        attempt=0
    fi
    
    attempt=$((attempt + 1))
done

