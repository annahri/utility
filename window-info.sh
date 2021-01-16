#!/bin/bash
# shows a little notification with useful window info

title="$(xdotool getactivewindow getwindowname)"
windowresourceid="$(xprop -root | grep _NET_ACTIVE_WINDOW\(WINDOW\) | cut -d \# -f 2)"
windowclass="$(xprop -id $windowresourceid | grep -i class | cut -d = -f 2)"
windowpid="$(xdotool getactivewindow getwindowpid)"

notify-send "$title" "Class: $windowclass \nPID: $windowpid"
