#!/bin/bash

YES_PROGS=$(find . -maxdepth 1 ! -name 'makefile' ! -name LICENSE ! -name '*.*')

for prog in $YES_PROGS
do
    echo $prog \| pv -brat \> /dev/null
    $prog | pv -brat > /dev/null
    echo
done

echo yes \| pv -brat \> /dev/null
yes | pv -brat > /dev/null
