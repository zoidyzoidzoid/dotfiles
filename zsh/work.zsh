#!/usr/bin/env zsh

function sup {
    eval "cd ~/src/superbalist/$1"
}

function sk {
    eval "cd ~/src/superbalist/superbalist-kubernetes/projects/$1"
}

function gcloud_filter_id {
    eval "gcloud compute instances list --filter=id:${1}"
}

alias sup-staging='gcloud config configurations activate superbalist-sandbox && kubectl config use-context gke_superbalist-sandbox_europe-west1-d_hive'
alias sup-prod='gcloud config configurations activate superbalist-966 && kubectl config use-context gke_superbalist-966_europe-west1-d_hive'

