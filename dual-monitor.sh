#!/bin/bash

# If second monitor attached on startup, set it up!

monitor_num="$(xrandr | grep -w connected | wc -l)"
[[ $monitor_num -eq 1 ]] && exit

monitor_prim="$(xrandr | grep -wi primary | awk '{print $1}')"
monitor_sec="$(xrandr | grep -w connected | grep -v primary | awk '{print $1}')"
monitor_sec_best="$(xrandr | grep "$monitor_sec" -A 5 | grep -w "1920x1080" | awk '{print $1}')"

# echo "Secondary monitor : $monitor_sec"
# echo "Best resolution   : $monitor_sec_best"

# read -p "Proceed?"

xrandr --output "$monitor_sec" --mode "$monitor_sec_best" --set audio force-dvi --set "Broadcast RGB" "Full" --right-of "$monitor_prim"


