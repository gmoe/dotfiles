#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo Updating submodules...

git submodule update --init --recursive

echo Linking dotfiles...

ln -s -f -i ${BASEDIR}/Brewfile ~/.Brewfile
touch ~/.Brewfile.local
brew bundle

# vim
if [ ! -d "~/.vim/" ]; then
  echo No .vim directory found, making...
  mkdir -p ~/.vim
fi

ln -s -f -i ${BASEDIR}/.vimrc ~/.vimrc
ln -s -f -i ${BASEDIR}/.vim/ ~/.vim/bundle

# zsh
ln -s -f -i ${BASEDIR}/.zshrc ~/.zshrc

# git
ln -s -f -i ${BASEDIR}/.gitconfig ~/.gitconfig
ln -s -f -i ${BASEDIR}/.gitignore_global ~/.gitignore_global

# tmux
ln -s -f -i ${BASEDIR}/.tmux/ ~/.tmux
ln -s -f -i ${BASEDIR}/.tmux.conf ~/.tmux.conf

# npm
ln -s -f -i ${BASEDIR}/.npmrc ~/.npmrc

# Pre-compile
autoload -Uz compinit
zcompile antigen/bin/antigen.zsh
