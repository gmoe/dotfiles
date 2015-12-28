#!/bin/bash


BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo Updating submodules...

git submodule update --init --recursive

echo Linking dotfiles...

# vim
ln -s -i ${BASEDIR}/.vimrc ~/.vimrc
ln -s -i ${BASEDIR}/.vim/ ~/.vim/bundle

# zsh
ln -s -i ${BASEDIR}/.zshrc ~/.zshrc

# git
ln -s -i ${BASEDIR}/.gitconfig ~/.gitconfig

# leiningen
ln -s -i ${BASEDIR}/.lein/profiles.clj ~/.lein/profiles.clj

# tmux
ln -s -i ${BASEDIR}/.tmux/ ~/.tmux
ln -s -i ${BASEDIR}/.tmux.conf ~/.tmux.conf
