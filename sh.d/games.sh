# -*- mode: sh -*-

if type net.fsuae.FS-UAE >/dev/null 2>&1; then
   alias uae="/usr/bin/flatpak run --command=fs-uae-launcher --file-forwarding net.fsuae.FS-UAE"
fi

if type org.libretro.RetroArch >/dev/null 2>&1; then
    alias retroarch=org.libretro.RetroArch
fi

alias sm64=$HOME/games/sm64/supermario64.sh
alias mame=$HOME/games/mame/execmame.sh
