#!/bin/bash

SIMTIME=
EXTRA2=-lxt

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
