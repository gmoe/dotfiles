# Dotfiles

These are my personal configuration files for ZSH, vim, tmux, and Leiningen.
They are meant to be used on both Linux and OS X. All files are kept in an
isolated directory and sym-linked to their required locations.

## Installation

Clone this repository into your home directory and run the installation script:

```sh
git clone https://github.com/gmoe/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Customization

Local machine customizations can be made by editing these files:

* Homebrew: `~/.Brewfile.local`
* ZSH: `~/.zshrc_local_after`, runs after `.zshrc`
* vim: `~/.vimrc_local`
* tmux: `~/.tmux_local.conf`

### Homebrew

I use [`brew bundle`][bundle] to maintain common software installs on macOS,
and I can configure each machine for a set of roles that influence what
software is installed.

On initial installation, roles are configured through a wizard when running
`brew bundle` and can be changed later by editing `Brewfile.roles` in the
dotfiles repo.

## License

Copyright (c) 2020 Griffin Moe. Released under the MIT License. See
[LICENSE.md][license].

[license]: LICENSE.md
[bundle]: https://github.com/Homebrew/homebrew-bundle
