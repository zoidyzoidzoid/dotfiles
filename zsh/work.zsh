#!/usr/bin/env zsh
setopt interactivecomments

function gcloud_filter_id {
    eval "gcloud compute instances list --filter=id:${1}"
}

alias sup-staging='gcloud config configurations activate superbalist-sandbox && kubectl config use-context gke_superbalist-sandbox_europe-west1-d_hive'
alias sup-prod='gcloud config configurations activate superbalist-966 && kubectl config use-context gke_superbalist-966_europe-west1-d_hive'

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
    eval "cd ~/workspace/$1"
}

function tal {
    eval "cd ~/workspace/$1"
}

