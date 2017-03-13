# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

# Load antigen
source ~/.dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle github
antigen bundle mercurial
antigen bundle pip
antigen bundle pyenv
antigen bundle pylint
antigen bundle python
antigen bundle lein
antigen bundle npm
antigen bundle command-not-found
antigen bundle colored-man-pages
antigen bundle colorize
antigen bundle cp

# Load the theme.
antigen theme robbyrussell

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Python autoenv
export AUTOENV_HANDLE_LEAVE=1
export AUTOENV_AUTH_FILE="~/.autoenv_authorized"
antigen bundle Tarrasch/zsh-autoenv

# Tell antigen that you're done.
antigen apply

export CLICOLOR="xterm-color"

# OS X / BSD colors for ls
export LSCOLORS="dxfxgxdxexcxGxxxxxxxxx"

# UNIX colors for ls
export LS_COLORS="di=1;34:fi=0:ln=31:pi=36:so=36:bd=36:cd=36:or=31:mi=33:ex=35:*.rpm=90"

export EDITOR="vim"
export DISABLE_AUTO_TITLE="true"

# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
  source ~/.zshrc_local_after
fi
