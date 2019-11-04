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
../../modules/jtframe/bin/sim.sh -mist $* -sysname popeye \
    -modules ../../modules -d SIM_UART -d GAME_ROM_LEN=$(stat -c%s $GAME_ROM_PATH) \
    -d SCANDOUBLER_DISABLE=1 
# -d SIMULATE_OSD