#!/bin/bash
if [ "$USBLASTER" = "" ]; then
    USBLASTER='$(quartus_pgm -l | grep -o "USB-Blaster.*")'
fi

quartus_pgm -c "$USBLASTER" jtpopeye.cdf