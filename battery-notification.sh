#! /usr/bin/env bash
# battery-notification.sh
# a script to send notifications based on battery level threshold

bat_level=$(cat /sys/class/power_supply/BAT0/capacity)
bat_status=$(cat /sys/class/power_supply/BAT0/status)

warn_threshold=${1:-10}
warn_sound="$HOME/.local/share/sounds/__custom/low_battery.mp3"
msg_title="Low Battery Alert!"
msg_text="Your battery level is critical ($bat_level%), please charge immediately."

echo "Battery status  : $bat_status" >&2
echo "Battery level   : $bat_level" >&2
echo "Alert threshold : $warn_threshold" >&2

if [[ ${bat_status,,} = "discharging" ]]; then
    if [[ $bat_level -le $warn_threshold ]]; then
        notify-send -u critical "$msg_title" "$msg_text"
        play -q "$warn_sound"
    else
        echo "Not sending notification." >&2
    fi
fi
