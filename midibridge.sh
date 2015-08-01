#!/bin/sh

# Look up the names / ports of USB-MIDI and Alesis then connect Alesis > USB-MIDI
if [ "$1" = "start" ]; then
    usb=$(aconnect -i | sed 's/://' | awk "BEGIN {dev=0;} /client [0-9]+ 'USB2.0-MIDI/ {dev=\$2;} END {print dev}")
    alesis=$(aconnect -i | sed 's/://' | awk "BEGIN {dev=0;} /client [0-9]+ 'Alesis/ {dev=\$2;} END {print dev}")
    
    if [ ! "$alesis" = "0" ] && [ ! "$usb" = "0" ]; then
        echo "aconnect $alesis $usb"
    else
        if [ "$alesis" = "0" ]; then
            echo "Cannot find Alesis drum kit"
        else
            echo "Cannot find USB-MIDI"
        fi
        exit -1
    fi
else
    # Lazy: Disconnect all ports-connects
    aconnect -x
fi
