#!/usr/bin/env zsh

function ne () {
    $(npm bin)/$*
}

export PATH="/usr/local/opt/node@8/bin:$PATH"
