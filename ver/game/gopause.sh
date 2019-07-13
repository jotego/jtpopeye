#!/bin/bash
export BIN2PNG_OPTIONS=="--overwrite --scale"
go.sh -d ALWAYS_PAUSE -frame 1 -video -deep $*