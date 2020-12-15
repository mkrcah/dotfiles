#! /usr/bin/env bash

set -euo pipefail

# pretty logging function
info () {
  printf "\r  [ \033[00;34mdotfiles\033[0m ] $1\n"
}

info "zsh: setting up zsh as default shell"
DEFAULT_SHELL=$(basename $(echo $SHELL))
if [ "$DEFAULT_SHELL" != "zsh" ]
then
  chsh -s "$(command -v zsh)"
fi

info "zsh: downloading antigen"
curl --silent -L git.io/antigen > antigen.zsh


info "brew: installing apps"
brew bundle --force

info "done, follow the checklist for manual steps."
cat <<EOF

Checklist of manual steps:
- Install the Dracula iterm2 theme from https://github.com/dracula/iterm.git
- Add JetBrains Font to iTerm2
- Setup git identities: https://www.micah.soy/posts/setting-up-git-identities/
- Log in to 1Password, Slack
- Turn on the macos disc encryption
- Setup shortcuts:
  - input sources: ^space:
EOF

# Automate the shortcuts:
# https://apple.stackexchange.com/questions/87619/where-are-keyboard-shortcuts-stored-for-backup-and-sync-purposes
# http://hints.macworld.com/article.php?story=20131123074223584
# https://apple.stackexchange.com/questions/79626/set-keystroke-for-service-from-terminal/79663#79663


