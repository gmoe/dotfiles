if [[ "$OSTYPE" == "darwin"* ]]; then
  # Remove unnecessary pinned dock items
  for app in 'App Store' 'Pages' 'Numbers' 'Keynote' 'News' 'Music' 'TV' 'Freeform' 'Notes' 'Reminders' 'Contacts' 'FaceTime' 'Photos' 'Maps' 'Safari';
    do dockutil --remove $app > /dev/null 2>&1;
  done

  # Require password immediately after sleep or screen saver
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0

  # Show hidden files in Finder
  defaults write come.apple.finder AppleShowAllFiles -bool true

  # Show file name extensions in Finder
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Bluetooth/Sound: always show in menu bar
  defaults -currentHost write com.apple.controlcenter Bluetooth -int 18
  defaults -currentHost write com.apple.controlcenter Sound -int 18

  # Battery - show percentage
  defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

  # Make dock sane
  defaults write com.apple.dock show-recents -bool false
  defaults write com.apple.dock show-process-indicators -bool true

  # Do not reorganize Mission Control spaces
  defaults write com.apple.dock mru-spaces -bool false

  # Set Caps Lock to Control
  hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc": 0x700000039, "HIDKeyboardModifierMappingDst": 0x7000000E0}]}' > /dev/null 2>&1

  # Faster trackpad tracking
  defaults write com.apple.trackpad.scaling -int 1

  # Sane trackpad gestures
  defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -int 1
  defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerHorizSwipeGesture" -int 0
  defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerVertSwipeGesture" -int 0
  defaults write com.apple.AppleMultitouchTrackpad "Clicking" -int 0
  defaults write com.apple.AppleBluetoothMultitouchTrackpad "Clicking" -int 0

  # Flush Dock to reflect current settings
  killall Dock
fi
