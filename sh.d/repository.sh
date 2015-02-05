#!/bin/bash

# Massimo Lauria, 2013
#
# Commands for controlling all my repositories
# simultaneously.


function myrepos() {
    MAINREPOS=(~/config ~/personal ~/lavori)
    COMMANDS=$@
    
    if [[ -z "$@" ]]; then
        COMMANDS=status
    fi
    
    for p in ${MAINREPOS[@]}; do
        echo "Executing '$COMMANDS' on repository $p"
        pushd $p
        git  $COMMANDS
        popd 
    done
    }


alias st="myrepos status"
alias push="myrepos push"
alias pull="myrepos pull"
alias gsync="myrepos pull && myrepos push"
