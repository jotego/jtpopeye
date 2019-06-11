#!/bin/bash

iverilog test.v dma.v ../../hdl/jtpopeye_{timing,cen,dma}.v \
    ../../modules/jtframe/hdl/jt74.v \
    ../../modules/jtframe/hdl/ram/jtgng_{ram,prom}.v \
    -o sim -stest -DSIMULATION -DMEM_CHECK_TIME=1000_000 && sim -lxt