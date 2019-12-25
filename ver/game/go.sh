#!/bin/bash
if [ ! -e ramsim.bin ]; then
    g++ ramsim.cc -o ramsim && ramsim    
fi

# Prepares the test memory file for objects
( iverilog objtest.v -o objtest && vvp objtest > objtest.hex ) \
    || exit 1;
( iverilog dmainit.v -o dmainit && vvp dmainit ) || exit 1

export MEM_CHECK_TIME=22_000_000
export GAME_ROM_PATH=../../rom/jtpopeye.rom
export YM2149=1

../../modules/jtframe/bin/sim.sh -mist $* -sysname popeye \
    -modules ../../modules -d GAME_ROM_LEN=$(stat -c%s $GAME_ROM_PATH) \
    -d COLORW=3 -d JTFRAME_INTERLACED
# -d SIMULATE_OSD