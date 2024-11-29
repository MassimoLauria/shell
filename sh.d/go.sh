#!/bin/sh

GOPATH=${HOME}/.local/go

if type go >/dev/null 2>&1; then
    go env -w GOPATH=$GOPATH
fi

export PATH="${GOPATH}/bin:$PATH"
