zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl true

autoload -Uz compinit
compinit

unsetopt list_ambiguous
setopt auto_remove_slash
unsetopt glob_dots
setopt chase_links
