#!/bin/bash
# Fill with zeros the file in $1 upto $2 kB

len=$(wc --bytes $1 | cut -d" " -f 1)
dd if=/dev/zero oflag=append conv=notrunc of=$1 bs=1 count=$(($2*1024-len))
