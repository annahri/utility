#!/usr/bin/env bash
# toggle on/off laptop mousepad

master_id=$(xinput list | grep 'Virtual core pointer' | sed -E 's/.*id=([0-9]+) *.*/\1/')
mouse_string=$(xinput list | grep -i 'synps/2 synaptics touchpad')
mouse_id=$(sed -E 's/.*id=([0-9]+) *.*/\1/' <<<"$mouse_string")

#check if there's external mouse
ext_mouse=$(find /dev/input/by-path -type l -name '*usb*mouse')
if [[ -z $ext_mouse ]]; then
    notify-send "No USB mouse attached!" "Won't turn off laptop mouse."
    exit
fi

if grep -q "slave  pointer" <<< "$mouse_string"; then
    # mouse is off
    notify-send -t 1000 "Laptop Mouse: OFF"
    xinput float $mouse_id
else
    notify-send -t 1000 "Laptop Mouse: ON"
    xinput reattach $mouse_id $master_id
fi
