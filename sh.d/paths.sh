#!/bin/sh

# Massimo Lauria, 2025
#
# Setup additional paths

# Flatpak local and global
PATH=$HOME/.local/share/flatpak/exports/bin/:$PATH
PATH=/var/lib/flatpak/exports/bin/:$PATH

# alternative installation paths
PATH=/opt/local/sbin:/opt/local/bin:$PATH
PATH=/usr/local/sbin:/usr/local/bin:$PATH
PATH=$HOME/.local/sbin:$HOME/.local/bin:$PATH
PATH=$HOME/Library/bin:$PATH


# programming environment stuff
PATH=$HOME/.elan/bin:$PATH
PATH=$HOME/.cargo/bin:$PATH
