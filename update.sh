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

# log sync message.
sync() {
	info "[$1] Sync changes..."
}

# log ok message.
ok() {
	success "[$1] OK"
}

# sync vim configurations.
sync_vim() {
	sync "vim"
	cp $HOME/.vimrc ./vim/vimrc
	ok "vim"
}

# sync neovim configurations.
sync_nvim() {
	sync "neovim"
	rm -rf ./nvim
	cp -r $HOME/.config/nvim ./nvim
	ok "neovim"
}

# sync alacritty configurations.
sync_alacritty() {
	sync "alacritty"
	cp $HOME/.config/alacritty/alacritty.yml ./alacritty/alacritty.yml
	ok "alacritty"
}

# sync tmux configurations.
sync_tmux() {
	sync "tmux"
	cp $HOME/.tmux.conf ./tmux/tmux.conf
	ok "tmux"
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
"tmux")
	sync_tmux
	;;
"all")
	sync_vim
	sync_nvim
	sync_alacritty
	sync_tmux
	;;
*)
	error "Invalid target"
	exit 1
	;;
esac
