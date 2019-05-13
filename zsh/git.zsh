#!/usr/bin/env zsh
alias fresh="git checkout master && git pull origin master"

function git-unmerged() {
  subl $(git status --porcelain|grep 'UU'| cat | cut -d\  -f2)
}

# From oh-my-zsh's lib/git.zsh
# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# Outputs the full git status, if it's quick, else without untracked files
# Usage example: git_status
function git_status() {
  local out
  out=$(command gtimeout 0.3s git status 2>/dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    out=$(command git status -uno 2> /dev/null) || return
  fi
  echo "${out}"
}

alias gs="git_status"

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

# Pushes to origin and opens a github compare view of it to speed up PR
# creation.
#
# To install add to $PATH with executable permission and run
#
#   git config --global alias.pr '!github-push-pr'
#
# Source: https://gist.github.com/keegancsmith/e565fbde4638e67c4f11704a4c84eee0

function github-push-pr {
  remote=origin
  branch=$(git symbolic-ref --short HEAD)

  # https://github.com/foo/bar.git -> foo/bar
  repo=$(git ls-remote --get-url ${remote} \
    | sed 's|^.*github.com[:/]\(.*\)$|\1|' \
    | sed 's|\(.*\)/$|\1|' \
    | sed 's|\(.*\)\(\.git\)|\1|')

  set -x
  open "https://github.com/${repo}/compare/${branch}?expand=1"
}

# Code inspired by the above, but for Gitlab url
# like 'hub url'
function gitlab-pr {
  remote=origin
  branch=$(git symbolic-ref --short HEAD)

  # https://github.com/foo/bar.git -> foo/bar
  repo=$(git ls-remote --get-url ${remote} \
    | sed -E 's|^(.*)(@\|://)([^:/]+)[:/](.*)$|\4|' \
    | sed 's|\(.*\)/$|\1|' \
    | sed 's|\(.*\)\(\.git\)|\1|')
  # https://gitlab.example.com/foo/bar.git -> gitlab.example.com
  base_url=$(git ls-remote --get-url ${remote} \
    | sed -E 's|^(.*)(@\|://)([^:/]+)(.*)$|\3|')

  target_branch=master
  case "$repo" in
    puppet/environments)
      target_branch=prod_pcm
      ;;
    core/main)
      target_branch=trunk
      ;;
  esac

  set -x
  open "https://${base_url}/${repo}/merge_requests/new?merge_request%5Bsource_branch%5D=${branch}&merge_request%5Btarget_branch%5D=${target_branch}"
}

function gitlab-url {
  remote=origin
  if [[ -z "$1" ]]; then
    sha=$(git rev-parse --short HEAD)
  else
    sha="$1"
  fi

  # https://github.com/foo/bar.git -> foo/bar
  repo=$(git ls-remote --get-url ${remote} \
    | sed -E 's|^(.*)(@\|://)([^:/]+)[:/](.*)$|\4|' \
    | sed 's|\(.*\)/$|\1|' \
    | sed 's|\(.*\)\(\.git\)|\1|')
  # https://gitlab.example.com/foo/bar.git -> gitlab.example.com
  base_url=$(git ls-remote --get-url ${remote} \
    | sed -E 's|^(.*)(@\|://)([^:/]+)(.*)$|\3|')

  set -x
  open "https://${base_url}/${repo}/commit/${sha}"
}
