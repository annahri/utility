#!/usr/bin/env bash
# a wrapper script to run another script forever
# usage: $cmd args=""

usage() {
    echo "$(basename $0) -i <interval> -s <script path> -args=\"<command arguments>\"" >&2
    exit
}

[[ $# -eq 0 ]] && usage
while [[ $# -ne 0 ]]; do case "$1" in
    -i) interval="${2:-5}" ;;
    -s) script="$2"   ;;
    -args) args="$2"  ;;
    *) echo "unknown flag"; exit ;;
esac; shift 2; done

# check if file is executable
[[ -f $script ]] || { echo "$script doesn't exist."; exit 1; }
[[ -x $script ]] || { echo "$script is not executable."; exit 1; }

notify-send "Script Sent to Background" "$script is now executed every $interval seconds"

script="$(readlink -f $script)"

while true; do
    $script "$args"
    sleep "$interval"
done

