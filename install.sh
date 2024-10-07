#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo Updating submodules...

git submodule sync --init --recursive
git submodule update

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
ln -s -f -i ${BASEDIR}/zsh_plugins.txt ~/.zsh_plugins.txt

# git
ln -s -f -i ${BASEDIR}/.gitconfig ~/.gitconfig
ln -s -f -i ${BASEDIR}/.gitignore_global ~/.gitignore_global

# tmux
ln -s -f -i ${BASEDIR}/.tmux/ ~/.tmux
ln -s -f -i ${BASEDIR}/.tmux.conf ~/.tmux.conf

# npm
ln -s -f -i ${BASEDIR}/.npmrc ~/.npmrc

if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Adding gruvbox to iTerm2, you will need to set this and Fira Code in your profile"
  open ${BASEDIR}/gruvbox.itermcolors
  ./macos.sh
fi
