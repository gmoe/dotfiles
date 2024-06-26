autoload -Uz compinit
compinit

source ~/.dotfiles/antidote/antidote.zsh
antidote load

export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile"

export CLICOLOR="xterm-color"
export LSCOLORS="dxfxgxdxexcxGxxxxxxxxx"
export LS_COLORS="di=1;34:fi=0:ln=31:pi=36:so=36:bd=36:cd=36:or=31:mi=33:ex=35:*.rpm=90"
export GREP_OPTIONS='--color=auto'

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# More visible vi-mode indicator
export MODE_INDICATOR="%{$fg_bold[blue]%}<NORMAL>%{$reset_color%}"

# Transition to Vi-mode set to 0.1s
export KEYTIMEOUT=1

export EDITOR="vim"
export DISABLE_AUTO_TITLE="true"

export ACKRC=".ackrc"

alias clang-tidy="$(brew --prefix llvm)/bin/clang-tidy" clang-format="$(brew --prefix llvm)/bin/clang-format"

if [ -f ~/.zshrc_local_after ]; then
  . ~/.zshrc_local_after
fi
