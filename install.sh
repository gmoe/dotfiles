#!/bin/bash


BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo Updating submodules...

git submodule update --init --recursive

echo Linking dotfiles...

ln -s -i ${BASEDIR}/Brewfile ~/.Brewfile
touch ~/.Brewfile.local

# vim
if [ ! -d "~/.vim/" ]; then
  echo No .vim directory found, making...
  mkdir ~/.vim
fi

ln -s -i ${BASEDIR}/.vimrc ~/.vimrc
ln -s -i ${BASEDIR}/.vim/ ~/.vim/bundle

# zsh
ln -s -i ${BASEDIR}/.zshrc ~/.zshrc

# git
ln -s -i ${BASEDIR}/.gitconfig ~/.gitconfig
ln -s -i ${BASEDIR}/.gitignore_global ~/.gitignore_global

# tmux
ln -s -i ${BASEDIR}/.tmux/ ~/.tmux
ln -s -i ${BASEDIR}/.tmux.conf ~/.tmux.conf
