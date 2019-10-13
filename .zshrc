# Load antigen
source ~/.dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle vi-mode # vi-mode indicator
antigen bundle colored-man-pages

# Load the theme.
antigen theme robbyrussell

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell antigen that you're done.
antigen apply

# autoload -U zmv

export CLICOLOR="xterm-color"

# OS X / BSD colors for ls
export LSCOLORS="dxfxgxdxexcxGxxxxxxxxx"

# UNIX colors for ls
export LS_COLORS="di=1;34:fi=0:ln=31:pi=36:so=36:bd=36:cd=36:or=31:mi=33:ex=35:*.rpm=90"

# Always use color in grep
export GREP_OPTIONS='--color=auto'

# Vi-like mode
bindkey -v

bindkey '^r' history-incremental-search-backward
bindkey '^w' backward-kill-word

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# More visible vi-mode indicator
export MODE_INDICATOR="%{$fg_bold[blue]%}<NORMAL>%{$reset_color%}"

# Transition to Vi-mode set to 0.1s
export KEYTIMEOUT=1

export EDITOR="vim"
export DISABLE_AUTO_TITLE="true"

# Tell ack to look for project-local ack configs
export ACKRC=".ackrc"

# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi
