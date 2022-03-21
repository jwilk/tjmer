#!/usr/bin/env bash

# Copyright © 2021-2022 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u

pdir="${0%/*}/.."
prog="$pdir/tjmer"

echo 1..5

t()
{
    n="$1"
    shift
    xout="$1"
    shift
    [ "$1" = tjmer ]
    shift
    out=$("$prog" "$@" 2>/dev/null)
    if [ "$out" = "$xout" ]
    then
        echo ok "$n"
    else
        echo not ok "$n"
    fi
}

unset TJMER_COMMAND
d=$(date +@%H:%M:%S -d '+2sec')
t 1 $'\a' tjmer "$d"
t 2 $'\a' tjmer 1s
p='\155\157\157'
t 3 'moo' tjmer 0s printf "$p"
export TJMER_COMMAND="printf '$p'"
t 4 'moo' tjmer 0s
p='\155\145\157\167'
t 5 'meow' tjmer 0s printf "$p"

# vim:ts=4 sts=4 sw=4 et ft=sh
