#!/bin/bash

echo Installing dotfiles...

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
ln -s ${BASEDIR}/.vimrc ~/.vimrc
ln -s ${BASEDIR}/.vim/ ~/.vim

# zsh
ln -s ${BASEDIR}/.zshrc ~/.zshrc

# git
ln -s ${BASEDIR}/.gitconfig ~/.gitconfig

# leiningen
ln -s ${BASEDIR}/.lein/profiles.clj ~/.lein/profiles.clj

# tmux
ln -s ${BASEDIR}/.tmux/ ~/.tmux
ln -s ${BASEDIR}/.tmux.conf ~/.tmux.conf
