# -*- mode: sh -*-


MAMECMD=$HOME/games/mame/groovymame
MAMEDIR=$HOME/games/mame
function mame {
    if [[ `pwd` == $MAMEDIR ]]; then
        ${MAMECMD} $@
    else
        pushd $MAMEDIR
        ${MAMECMD} $@
        popd
    fi
}

if type net.fsuae.FS-UAE >/dev/null 2>&1; then
   alias fs-uae=net.fsuae.FS-UAE
   alias fs-uae-launcher="/usr/bin/flatpak run --command=fs-uae-launcher --file-forwarding net.fsuae.FS-UAE"
   alias uae="/usr/bin/flatpak run --command=fs-uae-launcher --file-forwarding net.fsuae.FS-UAE"
   alias amiga="/usr/bin/flatpak run --command=fs-uae-launcher --file-forwarding net.fsuae.FS-UAE"
fi

if type org.libretro.RetroArch >/dev/null 2>&1; then
    alias retroarch=org.libretro.RetroArch
fi


function supermario64 {
    if [[ `pwd` == $HOME/games/sm64 ]]; then
        ./sm64.eu
    else
        pushd $HOME/games/sm64
        ./sm64.eu
        popd
    fi
}
