#Dotfiles

These are my personal configuration files for ZSH, vim, tmux, and Leiningen.
They are meant to be used on both Linux and OS X. All files are kept in an
isolated directory and sym-linked to their required locations.

##Usage

Clone this repository into your home directory and run the installation script:

```sh
git clone https://github.com/gmoe/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

Local customizations can be made by editing these files:
  
* ZSH: `~/.zshrc_local_before`, runs before `.zshrc`
* ZSH: `~/.zshrc_local_after`, runs after `.zshrc`
* vim: `~/.vimrc_local`
* tmux: `~/.tmux_local.conf`

##License

Copyright (c) 2015 Griffin Moe. Released under the MIT License. See [LICENSE.md][license].

[license]: LICENSE.md
