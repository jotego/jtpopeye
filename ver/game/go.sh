#!/bin/bash

export GAME_ROM_PATH=../../rom/jtpopeye.rom
../../modules/jtframe/bin/sim.sh -mist $* -sysname popeye \
    -modules ../../modules -d SIM_UART -d GAME_ROM_LEN=70464 \
    -d MEM_CHECK_TIME=22_000_000
