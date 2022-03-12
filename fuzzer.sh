#!/bin/bash -
#
# Description: 
# Fuzz a specified argument of a program
#
# Usage:
# bash fuzzer.sh <executable> <arg1> [?] <arg3> ... 
#   <executable> The target executable program/script
#   <argn> The static arguments for the executable
#   '?' The argument to be fuzzed
#   example:  fuzzer.sh ./myprog -t '?' fn1 fn2
#

function usagexit ()
{
    echo "usage: $0 executable args"
    echo "example: $0 myapp -lpt arg \?"
    exit 1
} >&2

if (($# < 2))
then
    usagexit
fi

THEAPP="$1"
shift
type -t "$THEAPP" >/dev/null || usagexit

declare -i i
for ((i = 0; $#; i++))
do
    ALIST+=( "$1" )
    if [[ $1 == '?' ]]
    then
	    NDX=$i
    fi
    shift
done

MAX=10000
FUZONE="a"
FUZARG=""

for ((i = 1; i <= MAX; i++))
do
    FUZARG="${FUZARG}${FUZONE}"
    ALIST[$NDX]="$FUZARG"
    $THEAPP "${ALIST[@]}" 2>&1 >/dev/null
    if (( $? ))
    then
        echo "Caused by: $FUZARG" >&2
    fi
done
