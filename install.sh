#!/usr/bin/env bash

#
# This script is designed to install and apply configurations.
#

set -e

WORKING_DIR=$(pwd)

# source utils
source "${WORKING_DIR}"/utils.sh

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

# log install message.
install() {
  info "[$1] Installing..."
}

# log ok message.
ok() {
  success "[$1] OK"
}

# Prepare
CONFIG_DIR=$HOME/.config

if [[ ! -d "$CONFIG_DIR" ]]; then
  mkdir -p $CONFIG_DIR
fi

# Check what shell is being used
SH="${HOME}/.bashrc"
ZSHRC="${HOME}/.zshrc"
SHELL_DIR="$HOME/.shell"

if [ -f "$ZSHRC" ]; then
  SH="$ZSHRC"
fi

# install vim configurations.
install_vim() {
  install "vim"

  link_file $PWD/vim/vimrc $HOME/.vimrc

  ok "vim"
}

# install vim basic configurations.
install_vim_basic() {
  install "vim_basic"

  link_file $PWD/vim/vimrc-basic $HOME/.vimrc

  ok "vim-basic"
}

# install neovim configurations.
install_nvim() {
  install "neovim"

  link_file $PWD/nvim $HOME/.config/nvim

  ok "neovim"
}

# install alacritty configurations.
install_alacritty() {
  install "alacritty"

  mkdir -p $HOME/.config/alacritty
  link_file $PWD/alacritty/alacritty.toml $HOME/.config/alacritty/alacritty.toml

  info "[alacritty] Installing alacritty theme..."
  info "[alacritty]   for more information on available themes, please see https://github.com/alacritty/alacritty-theme#color-schemes"
  git clone https://github.com/alacritty/alacritty-theme $HOME/.config/alacritty/alacritty-theme

  ok "alacritty"
}

# install tmux configurations.
install_tmux() {
  install "tmux"

  link_file $PWD/tmux/tmux.conf $HOME/.tmux.conf

  ok "tmux"
}

# install starship configurations.
install_starship() {
  install "starship"

  link_file $PWD/starship/starship.toml $HOME/.config/starship.toml

  ok "starship"
}

# install shells
install_shell() {
  if [[ ! -d "$SHELL_DIR" ]]; then
    mkdir $SHELL_DIR
  fi

  for file in shell/*; do
    if [[ -f "$file" ]]; then
      local filename src dst
      filename=$(basename "$file")
      src=$(realpath "$file")
      dst="$SHELL_DIR/$filename"

      if [[ -e "$dst" ]]; then
        if ask "${filename} already exists, overwrite?"; then
          ln -sf $src $dst
        fi
      else
        ln -s $src $dst
      fi

      if ! $(grep ".shell/$filename" $SH >/dev/null 2>&1); then
        echo "source ~/.shell/$filename" >>"$SH"
      fi
    fi
  done

  ok "shell"
}

#
# Main
#

case "$TARGET" in
  "vim")
    install_vim
    ;;
  "vim_basic")
    install_vim_basic
    ;;
  "nvim")
    install_nvim
    ;;
  "alacritty")
    install_alacritty
    ;;
  "tmux")
    install_tmux
    ;;
  "starship")
    install_starship
    ;;
  "shell")
    install_shell
    ;;
  "all")
    install_vim
    install_nvim
    install_alacritty
    install_tmux
    install_shell
    ;;
  *)
    fail "Unsupported target: $TARGET"
    ;;
esac
