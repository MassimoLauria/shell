#!/bin/sh

# Setup for GEF (Gdb Enhanced Features)

_gef_check_install() {
    [ -f ~/.gdbinit-gef.py ] ||
        wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
}

gef() {
    _gef_check_install || return 1
    gdb -ix ~/.gdbinit-gef.py $@
}
