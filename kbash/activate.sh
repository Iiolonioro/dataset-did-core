#!/bin/bash

# uncommenting this line will cause trace output
#export KBASH_TRACE=true

export DIDCORE="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# change this if you did not clone into ~/.kbash
. $DIDCORE/.kbash/boot.sh\
    "dc"  \
    "DIDCORE"  \
    ""            \
    ""
#:
#: # activate.sh
#:
#:
#:
#:
#:
#:
#:
