require './prompt'

roles = BrewRoles.prompt_for_roles

tap "homebrew/bundle"
tap "homebrew/services"
tap "beeftornado/rmtree"

brew "ack"
brew "direnv"
brew "gcc"
brew "git"
brew "llvm"
brew "loc"
brew "mas"
brew "node"
brew "nvm"
brew "sqlite"
brew "python"
brew "shellcheck"
brew "tmux"
brew "vim"
brew "zsh"

mas "Xcode", id: 497799835
mas "Deliveries", id: 290986013

cask "bitwarden"
cask "discord"
cask "firefox"
cask "figma"
cask "focusrite-control"
cask "font-fira-code"
cask "gimp"
cask "iterm2"
cask "obsidian"
cask "signal"
cask "slack"
cask "standard-notes"
cask "vlc"

if roles.include?("music") then
  cask "elektron-overbridge"
  cask "elektron-transfer"
  cask "cycling74-max"
end

if roles.include?("games") then
  cask "mgba"
  cask "multipatch"
end

if roles.include?("latex") then
  cask "mactex"
end

instance_eval(File.read(File.join(Dir.home, ".Brewfile.local")))
