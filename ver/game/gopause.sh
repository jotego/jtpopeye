#!/bin/bash
export BIN2PNG_OPTIONS=="--overwrite"
go.sh -d ALWAYS_PAUSE -frame 1 -video -deep $*