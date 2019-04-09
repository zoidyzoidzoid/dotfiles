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

export EDITOR='nvim'

export PATH=$PATH:/usr/local/opt/go/libexec/bin

function new_jekyll_post() {
    fn="_posts/$(date "+%Y-%m-%d")-$1.markdown"
    echo "Creating ${fn}"
    touch "${fn}"
}

function org {
  eval "cd ~/src/org/$1"
}

function dedupHistory() {
    cp ~/.zsh_history{,-old}
    tmpFile=`mktemp`
    awk -F ";" '!seen[$2]++' ~/.zsh_history > $tmpFile
    mv $tmpFile ~/.zsh_history
}
