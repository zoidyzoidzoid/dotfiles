#!/usr/bin/env zsh
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export CC=clang

alias ~e='vim ~/.zshrc'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

export EDITOR='mvim -v'

export PATH=$PATH:/usr/local/opt/go/libexec/bin

function new_jekyll_post() {
    touch "_posts/$(date "+%Y-%m-%d")-$1.markdown"
}

function org {
  eval "cd ~/src/org/$1"
}
