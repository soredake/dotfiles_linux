#!/bin/bash
activeport=$(pacmd list-sinks | grep -E 'active port: <analog-output-(lineout|headphones)>')
_sink='alsa_output.pci-0000_00_1b.0.analog-stereo'
pasink() { pactl set-sink-port "$_sink" "$1"; echo "port \"$1\" is now active"; }
case $activeport in
    *analog-output-lineout*) pasink analog-output-headphones ;;
    *analog-output-headphones*) pasink analog-output-lineout ;;
    *) echo "no matching ports found" ;;
esac
