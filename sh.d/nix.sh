#!/bin/sh

# Configuration for the nix package manager


NIXCONF=${HOME}/.nix-profile/etc/profile.d/nixs.sh

if [ -f $NIXCONF ]; then
    source $NIXCONF
fi
