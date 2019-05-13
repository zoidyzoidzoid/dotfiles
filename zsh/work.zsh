#!/usr/bin/env zsh
setopt interactivecomments

function wk {
    eval "cd ~/work/$1"
}

function puppet-pull-branch {
  ssh ps "cd /etc/puppet/environments/wstewart && git fetch origin && git checkout $(git branch | grep "*" | awk '{print $2}') && git pull"
}

function puppet6-pull-branch {
  ssh ps6 "cd /etc/puppetlabs/code/environments/wstewart && git fetch origin && git checkout $(git branch | grep "*" | awk '{print $2}') && git pull"
}
