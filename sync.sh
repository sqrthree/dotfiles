#!/bin/sh

#
# This script is designed to sync local configuration files into current directory,
# so that the changes can be tracked with git.
#

set -e

#
# Vars
#

TARGET=$1

if [ -z "$TARGET" ]; then
  TARGET="all"
fi

#
# Functions
#

# log a message with info level.
info() {
  echo "\033[34m[*] $1\033[0m"
}

# log a message with warning level.
warn() {
  echo "\033[33m[!] $1\033[0m"
}

# log a message with success level.
success() {
  echo "\033[32m[✔] $1\033[0m"
}

# log a message with error level.
error() {
  echo "\033[31m[x] $1\033[0m"
}

# log sync message.
sync() {
  info "[$1] sync changes..."
}

# log ok message.
ok() {
  success "[$1] ok"
}

# sync vim configurations.
sync_vim() {
  sync "vim"
  cp ~/.vimrc ./vim/vimrc
  ok "vim"
}

# sync neovim configurations.
sync_nvim() {
  sync "neovim"
  rm -rf ./nvim
  cp -r ~/.config/nvim ./nvim
  ok "neovim"
}

# sync alacritty configurations.
sync_alacritty() {
  sync "alacritty"
  cp  ~/.config/alacritty/alacritty.yml ./alacritty/alacritty.yml
  ok "alacritty"
}

#
# Main
#

case "$TARGET" in
  "vim")
    sync_vim
    ;;
  "nvim")
    sync_nvim
    ;;
  "alacritty")
    sync_alacritty
    ;;
  "all")
    sync_vim
    sync_nvim
    sync_alacritty
    ;;
  *)
    error "Invalid target"
    exit 1
    ;;
esac
