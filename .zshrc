. ~/.dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle vi-mode
antigen bundle colored-man-pages
antigen theme robbyrussell
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen apply

export CLICOLOR="xterm-color"
export LSCOLORS="dxfxgxdxexcxGxxxxxxxxx"
export LS_COLORS="di=1;34:fi=0:ln=31:pi=36:so=36:bd=36:cd=36:or=31:mi=33:ex=35:*.rpm=90"
export GREP_OPTIONS='--color=auto'

# Better history search bindings
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

# Add vim-tidal to path
export PATH="$HOME/.dotfiles/.vim/vim-tidal/bin:$PATH"

export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile"

# Allow per-machine customizations
if [ -f ~/.zshrc_local_after ]; then
  . ~/.zshrc_local_after
fi
