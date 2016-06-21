#!/bin/bash

HOME=/home/mobb
VENVDIR=$HOME/pypy-venv
SRCDIR=$HOME/findme

cd $VENVDIR
. bin/activate
cd $SRCDIR
crossbar start
python client.py
