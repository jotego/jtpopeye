#!/bin/bash

SIMTIME=
EXTRA2=-lxt

echo "Importing netlist"
../../modules/jtframe/cc/pcb2ver ../popeye/popeye_model.net \
    --lib ../../modules/jtframe/hdl/jt74.v \
    --ports dma.v --wires \
    > dma_model.v

# create blank rom files if they don't exist
for i in 0 1; do
    for j in 0 1 2 3; do
        if [ ! -e dma${j}${i}.bin ]; then
            dd if=/dev/zero of=dma${j}${i}.bin bs=256 count=1
        fi
    done
done

while [ $# -gt 0 ]; do
    case $1 in
        -time) 
            shift
            if [ "$1" = "" ]; then
                echo "Missing time argument afte -time"
                exit 1
            fi
            SIMTIME="-DSIMTIME=$1"
            ;;
        -deep)
            EXTRA="$EXTRA -DDUMPALL";;
        -vcd)
            EXTRA="$EXTRA -DVCD"
            EXTRA2=;;
        *)  echo Unknown argument $1
            exit 1;;
    esac
    shift
done

iverilog test.v dma.v ../../hdl/jtpopeye_{timing,cen,dma}.v \
    ../../modules/jtframe/hdl/jt74.v \
    ../../modules/jtframe/hdl/ram/jtgng_{ram,prom}.v \
    $SIMTIME $EXTRA\
    -o sim -stest -DSIMULATION -DMEM_CHECK_TIME=1000_000 && sim $EXTRA2
