#!/usr/bin/env zsh
setopt interactivecomments

function gcloud_filter_id {
    eval "gcloud compute instances list --filter=id:${1}"
}

alias ks='kubectl --context staging'
alias ksm='kubectl --context staging -n master'
alias kp='kubectl --context production'


alias ss='stern --context staging'
alias ssm='stern --context staging -n master'
alias sp='stern --context production'


alias hs='helm --kube-context staging'
alias hp='helm --kube-context production'

alias as='ark --kubecontext staging'
alias ap='ark --kubecontext production'

function wk {
    eval "cd ~/work/$1"
}

function puppet-pull-branch {
  ssh puppet-staging "cd /etc/puppet/environments/wstewart/puppet && git fetch origin && git checkout $(git branch | grep "*" | awk '{print $2}') && git pull"
}
