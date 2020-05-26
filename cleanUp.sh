#!/bin/bash

for f in *
do
    if !(echo $f | grep "\.hs$") && !(echo $f | grep "\.sh$"); then
        rm $f
    fi
done