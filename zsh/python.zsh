#!/usr/bin/env zsh

alias vv='python2.7 -m virtualenv virtualenv'
alias venv='source virtualenv/bin/activate'
alias v='source virtualenv/bin/activate'
alias dv='deactivate'
alias ipy='ipython'
alias vv-2.7='python2.7 -m virtualenv virtualenv'
alias vv-3.5='python3.5 -m virtualenv virtualenv'

alias pip='noglob pip'

export PATH="${HOME}/.pyenv/shims:${PATH}"
export PYENV_SHELL=zsh

eval "$(command pyenv init -)"

pyenv() {
  eval "$(command pyenv-virtualenv-init -)"
  command pyenv "$@"
}
