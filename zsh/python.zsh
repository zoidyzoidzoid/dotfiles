#!/usr/bin/env zsh

alias vv='python2.7 -m virtualenv virtualenv'
alias venv='source virtualenv/bin/activate'
alias v='source virtualenv/bin/activate'
alias dv='deactivate'
alias ipy='ipython'
alias vv-2.7='python2.7 -m virtualenv virtualenv'
alias vv-3.5='python3.5 -m virtualenv virtualenv'

alias pip='noglob pip'

if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi
