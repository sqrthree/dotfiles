#!/bin/sh

#
# This script is designed to install and apply configurations.
#

set -e

#
# Vars
#

TARGET=$1
NOW=$(date +%Y%m%d%H%M%S)

if [ -z "$TARGET" ]; then
  TARGET="all"
fi

#
# Functions
#

# log a message with info level.
info() {
  echo -e "\033[34m[*] $1\033[0m"
}

# log a message with warning level.
warn() {
  echo -e "\033[43m[!] $1\033[0m"
}

# log a message with success level.
success() {
  echo -e "\033[32m[✔] $1\033[0m"
}

# log a message with error level.
error() {
  echo -e "\033[41m[x] $1\033[0m"
}

# log install message.
install() {
  info "[$1] Installing..."
}

# log ok message.
ok() {
  success "[$1] OK"
}

# backup files
backup() {
  if [ -e "$2" ];then
    BACKUP_FILE_NAME="$2.$NOW.backup"

    info "[$1] Detected that the configuration file already exists:"
    info "[$1]   file: $2"
    info "[$1] Trying to backup files..."
    info "[$1]   $2 => $BACKUP_FILE_NAME"
    mv $2 $BACKUP_FILE_NAME
    info "[$1] The file has been backed up."
  fi
}

# install vim configurations.
install_vim() {
  backup "vim" "$HOME/.vimrc"

  install "vim"
  cp ./vim/vimrc ~/.vimrc

  ok "vim"
}

# install vim basic configurations.
install_vim_basic() {
  backup "vim-basic" "$HOME/.vimrc"

  install "vim_basic"
  cp ./vim/vimrc-basic ~/.vimrc

  ok "vim-basic"
}

# install neovim configurations.
install_nvim() {
  backup "neovim" "$HOME/.config/nvim"

  install "neovim"
  if [ -d "$HOME/.config/nvim" ];then
    rm -r ~/.config/nvim
  fi
  cp -r ./nvim ~/.config/nvim

  ok "neovim"
}

# install alacritty configurations.
install_alacritty() {
  backup "alacritty" "$HOME/.config/alacritty"

  install "alacritty"
  mkdir -p ~/.config/alacritty
  cp ./alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

  info "[alacritty] Installing alacritty theme..."
  info "[alacritty]   for more information on available themes, please see https://github.com/alacritty/alacritty-theme#color-schemes"
  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

  ok "alacritty"
}

# install tmux configurations.
install_tmux() {
  backup "tmux" "$HOME/.tmux.conf"

  install "tmux"
  cp ./tmux/tmux.conf ~/.tmux.conf

  ok "tmux"
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
  "all")
    install_vim
    install_nvim
    install_alacritty
    install_tmux
    ;;
  *)
    error "Invalid target"
    exit 1
    ;;
esac
