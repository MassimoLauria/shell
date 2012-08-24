#!/bin/sh
#
# Copyright (C) 2012 by Massimo Lauria
#
# Created   : "2012-08-24, 14:24 (CEST) Massimo Lauria"
# Time-stamp: "2012-08-24, 14:31 (CEST) Massimo Lauria"
#
# Description::
#
# Gnome forces TERM variable to be xterm, but I often want xterm-256color.

# Code::

if [ "$TERM" = "xterm" -a  "$COLORTERM" = "gnome-terminal" ]; then
    # No it isn't, it's gnome-terminal
    export TERM=xterm-256color
fi

# Local Variables:
# fill-column: 80
# End:
