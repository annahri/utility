#!/usr/bin/env bash

maim -i $(xdotool getactivewindow) --format=png /dev/stdout | xclip -selection clipboard -t image/png -i \
    && notify-send -t 5000 "Window captured!" "The capture is stored in clipboard"

play -q "$HOME/.local/share/sounds/__custom/palm_shutter.mp3"
