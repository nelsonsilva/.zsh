export ZSH=$HOME/.zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Load custom plugins
for plugin ($ZSH/plugins/*.zsh) source $plugin

# emacs mode
bindkey -e

POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs)
source  $ZSH/powerlevel9k/powerlevel9k.zsh-theme
