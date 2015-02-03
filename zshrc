export ZSH=$HOME/.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Load custom plugins
for plugin ($ZSH/plugins/*.zsh) source $plugin

# emacs mode
bindkey -e
