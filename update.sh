#!/bin/zsh

git pull
git submodule update --init --remote
brew bundle

# Pre-compile
autoload -Uz compinit
zcompile antigen/bin/antigen.zsh
