#!/usr/bin/env bash
# toggle on/off laptop keyboard

master_id=$(xinput list | grep 'Virtual core keyboard' | sed -E 's/.*id=([0-9]+) *.*/\1/')
kbd_string=$(xinput list | grep -i 'at translated set 2 keyboard')
kbd_id=$(sed -E 's/.*id=([0-9]+) *.*/\1/' <<<"$kbd_string")

#check if there's external keyboard
ext_kbd=$(find /dev/input/by-path -type l -name '*usb*kbd')
if [[ -z $ext_kbd ]]; then
    notify-send "No USB keyboard attached!" "Won't turn off laptop keyboard."
    exit
fi

if grep -q "slave  keyboard" <<< "$kbd_string"; then
    # keyboard is off
    notify-send -t 1000 "Laptop Keyboard: OFF"
    xinput float $kbd_id
else
    notify-send -t 1000 "Laptop Keyboard: ON"
    xinput reattach $kbd_id $master_id
fi
