if [[ "$(uname -s)" == 'Darwin' ]]; then
  alias vim="nvim"

  brew_update() {
    brew upgrade --cleanup && brew cleanup -s
  }
fi

