#!/bin/bash
iverilog objcmp.v ../../modules/jtframe/hdl/jt74.v  -o objcmp  -s objcmp \
    && vvp objcmp -lxt