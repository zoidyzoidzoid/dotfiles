#!/usr/bin/env sh
# Outputs the full git status, if it's quick, else without untracked files
# Usage example: git_status
function git_status() {
  local out
  out=$(command gtimeout 0.3s git -c color.status=always status 2>/dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    out=$(command git -c color.status=always status -uno 2> /dev/null) || return
  fi
  echo "${out}"
}

git_status


