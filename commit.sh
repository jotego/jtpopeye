#!/bin/bash
msg="$1"
if [ "$msg" = "" ]; then
    msg=wip
fi

cd modules/jtframe
git commit -a -m "$msg" $*
cd ../..
git add modules/jtframe
git commit -a -m "$msg"