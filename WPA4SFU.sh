#!/bin/bash

echo -e "  ____      _    __     __        __    _ "
echo -e " / ___|   _| | __\\ \\   / /__  _ _\\ \\  / /"
echo -e "| |  | | | | |/ _ \\ \\ / / _ \\| '__\\ \\/ / "
echo -e "| |__| |_| | | (_) \\ V / (_) | |   \\  /  "
echo -e " \\____\\__, |_|\___/ \\_/ \\___/|_|    \\/   "
echo -e "      |___/                               "

echo -e 
echo -e  Start WLAN adapter in monitor mode
echo -e Start as Root User!

echo -e "\nMenu:"
echo "1. Crack WPA3"
echo "2. DOS WPA3"
echo "3. Stealer"
echo "4. Stealer 2x WLAN Interfaces"
echo -e

read -p "Enter your choice: " choice

case $choice in
    1)
        ./bin/crack.sh
        ;;
    2)
        ./bin/dos.sh
        ;;
    3)
        ./bin/steal.sh
        ;;
    4)
        ./bin/hs.sh
        ;;

    *)
        echo "Invalid choice"
        ;;
esac
