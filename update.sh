#!/bin/zsh

git pull
git submodule update --init --remote

autoload -Uz compinit
zcompile antigen/bin/antigen.zsh
