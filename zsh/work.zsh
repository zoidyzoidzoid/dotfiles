#!/usr/bin/env zsh
setopt interactivecomments

function wk {
    eval "cd ~/work/$1"
}

function puppet-pull-branch {
  ssh puppet-staging "cd /etc/puppet/environments/wstewart && git fetch origin && git checkout $(git branch | grep "*" | awk '{print $2}') && git pull"
}
