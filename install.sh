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
NOW=$(date +%Y%m%d%H%M%S)

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

# backup files
backup() {
	if [ -e $2 ]; then
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
	cp ./vim/vimrc $HOME/.vimrc

	ok "vim"
}

# install vim basic configurations.
install_vim_basic() {
	backup "vim-basic" "$HOME/.vimrc"

	install "vim_basic"
	cp ./vim/vimrc-basic $HOME/.vimrc

	ok "vim-basic"
}

# install neovim configurations.
install_nvim() {
	backup "neovim" "$HOME/.config/nvim"

	install "neovim"
	if [ -d $HOME/.config/nvim ]; then
		rm -r $HOME/.config/nvim
	fi
	cp -r ./nvim $HOME/.config/nvim

	ok "neovim"
}

# install alacritty configurations.
install_alacritty() {
	backup "alacritty" "$HOME/.config/alacritty"

	install "alacritty"
	mkdir -p $HOME/.config/alacritty
	cp ./alacritty/alacritty.toml $HOME/.config/alacritty/alacritty.toml

	info "[alacritty] Installing alacritty theme..."
	info "[alacritty]   for more information on available themes, please see https://github.com/alacritty/alacritty-theme#color-schemes"
	git clone https://github.com/alacritty/alacritty-theme $HOME/.config/alacritty/alacritty-theme

	ok "alacritty"
}

# install tmux configurations.
install_tmux() {
	backup "tmux" "$HOME/.tmux.conf"

	install "tmux"
	cp ./tmux/tmux.conf $HOME/.tmux.conf

	ok "tmux"
}

# install starship configurations.
install_starship() {
	backup "starship" "$HOME/.config/starship.toml"

	install "starship"

	mkdir -p $HOME/.config
	cp ./starship/starship.toml $HOME/.config/starship.toml

	ok "starship"
}

# Check what shell is being used
SH="${HOME}/.bashrc"
ZSHRC="${HOME}/.zshrc"
SHELL_DIR="$HOME/.shell"

if [ -f "$ZSHRC" ]; then
	SH="$ZSHRC"
fi

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
