require './prompt'

roles = BrewRoles.prompt_for_roles

tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/core"
tap "homebrew/services"
tap "homebrew/cask-drivers"
tap "beeftornado/rmtree"

mas "Xcode", id: 497799835
mas "Deliveries", id: 290986013

brew "ack"
brew "cabal-install"
brew "cmake"
brew "gcc"
brew "git"
brew "llvm"
brew "loc"
brew "mas"
brew "node"
brew "sqlite"
brew "python"
brew "shellcheck"
brew "tmux"
brew "vim"
brew "zsh"

cask "bitwarden"
cask "firefox"
cask "focusrite-control"
cask "font-fira-code"
cask "gimp"
cask "iterm2"
cask "sketch"
cask "slack"
cask "standard-notes"
cask "mactex"
cask "vlc"
cask "zsa-wally"

if roles.include?("music") then
  cask "elektron-overbridge"
  cask "elektron-transfer"
end

if roles.include?("games") then
  cask "mgba"
  cask "multipatch"
end

instance_eval(File.read(File.join(Dir.home, ".Brewfile.local")))
