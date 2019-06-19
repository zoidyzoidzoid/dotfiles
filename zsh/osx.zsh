if [[ "$(uname -s)" == 'Darwin' ]]; then
  alias vim="nvim"

  brew_update() {
    brew update
	brew upgrade
	brew cleanup -s
  }
  cd() {
    builtin cd $@ && exa
  }
fi

