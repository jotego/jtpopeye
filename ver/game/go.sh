#!/bin/bash
if [ ! -e ramsim.bin ]; then
    g++ ramsim.cc -o ramsim && ramsim    
fi

export MEM_CHECK_TIME=22_000_000
export GAME_ROM_PATH=../../rom/jtpopeye.rom
../../modules/jtframe/bin/sim.sh -mist $* -sysname popeye \
    -modules ../../modules -d SIM_UART -d GAME_ROM_LEN=70464 \
    -d SCANDOUBLER_DISABLE=1 
# -d SIMULATE_OSD