if [[ "$(uname -s)" == 'Darwin' ]]; then
  alias vim="mvim -v"

  brew_update() {
    brew update && brew upgrade && brew cleanup -s
  }
fi

