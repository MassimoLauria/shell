#!/bin/sh

# Configuration for the nix package manager


NIXCONF=${HOME}/.nix-profile/etc/profile.d/nix.sh

if [ -f $NIXCONF ]; then
    source $NIXCONF
fi
