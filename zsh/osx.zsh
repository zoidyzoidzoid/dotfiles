if [[ "$(uname -s)" == 'Darwin' ]]; then
  alias vim="mvim -v"

  brew_update() {
    brew upgrade --cleanup && brew cleanup -s
  }
fi

