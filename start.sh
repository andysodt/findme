#!/bin/bash
#2539731325

HOME=/home/mobb
VENVDIR=$HOME/pypy-venv
SRCDIR=$HOME/findme

cd $VENVDIR
. bin/activate
cd $SRCDIR
crossbar start
