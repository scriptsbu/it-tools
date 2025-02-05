#!/bin/bash

# Wi-Fi Troubleshooting Script

# Function to check Wi-Fi status
check_wifi_status() {
    echo "Checking current Wi-Fi connection status..."
    nmcli -f IN-USE,SSID,SIGNAL,BARS dev wifi | grep '*'
}

# Function to display connection details
display_connection_details() {
    echo -e "\nCurrent active Wi-Fi Connection Details:"
    nmcli -f ALL connection show --active | grep -A 10 "wifi" | grep -v "wifi"
}

# Function to check network connectivity
check_internet_connectivity() {
    echo -e "\nChecking internet connectivity..."
    if ping -c 4 8.8.8.8 > /dev/null; then
        echo "Internet is reachable."
    else
        echo "Internet is not reachable. Check your connection."
    fi
}

# Function to provide suggestions based on signal strength
suggestions_based_on_signal() {
    echo -e "\nSuggestions based on signal strength:"
    signal=$(nmcli -f SIGNAL dev wifi | grep -v "SIGNAL" | awk 'NR==1')
    
    if [ "$signal" -lt 30 ]; then
        echo "Signal is weak. Consider moving closer to the router."
        echo "If you're unsure where the router is, try to follow the signal strength as you walk around."
        echo "You can monitor your signal by running: watch -n 1 iwconfig"
        echo "Press Ctrl + C to exit this monitoring."
    elif [ "$signal" -lt 60 ]; then
        echo "Signal is fair. You may experience some connectivity issues."
        echo "Consider moving closer to the router for a better connection."
        echo "You can monitor your signal by running: watch -n 1 iwconfig"
        echo "Press Ctrl + C to exit this monitoring."
    else
        echo "Signal is strong. Your connection should be stable."
    fi
}

# Main function to execute all checks
main() {
    check_wifi_status
    display_connection_details
    check_internet_connectivity
    suggestions_based_on_signal
}

# Execute the main function
main

echo -e "\nWi-Fi troubleshooting completed."
echo "To exit the script at any time, press Ctrl + C."
