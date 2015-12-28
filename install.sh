#!/bin/bash


BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo Installing dotfiles...

# vim
ln -s ${BASEDIR}/.vimrc ~/.vimrc
ln -s ${BASEDIR}/.vim/ ~/.vim/bundle

# zsh
ln -s ${BASEDIR}/.zshrc ~/.zshrc

# git
ln -s ${BASEDIR}/.gitconfig ~/.gitconfig

# leiningen
ln -s ${BASEDIR}/.lein/profiles.clj ~/.lein/profiles.clj

# tmux
ln -s ${BASEDIR}/.tmux/ ~/.tmux
ln -s ${BASEDIR}/.tmux.conf ~/.tmux.conf
