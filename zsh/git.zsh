#!/usr/bin/env zsh
alias fresh="git checkout master && git pull origin master"

function git-unmerged() {
   subl $(git status --porcelain|grep 'UU'| cat | cut -d\  -f2)
}

parse_git_branch () {
    git branch 2> /dev/null | grep "*" | sed -e 's/* \(.*\)/ (\1)/g'
}

function git-clean() {
    local master=${1:-master}
    CURRENT_BRANCH=`parse_git_branch` &&
    git checkout $master &&
    git pull origin $master &&
    git branch --merged $master --no-color | grep -v "$master" | xargs -n 1 git branch -d &&
    echo "Last branch was: $CURRENT_BRANCH"
}

function git-clean-remote() {
    local master=${1:-master}
    git fetch -p origin &&
    git branch -r --merged | \
    grep origin | \
    grep -v '>' | \
    grep -v $master | \
    xargs -L1 | \
    cut -d"/" -f2- | \
    xargs git push origin --delete
}

function gi {
    eval "cd ~/src/$1"
}

alias g=git
