#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
  set -o xtrace
fi

cd "$(dirname "$0")"

# source utils
source "../utils.sh"

# install alacritty configurations.
install_alacritty() {
  install "alacritty"

  mkdir -p $HOME/.config/alacritty
  link_file $PWD/alacritty.toml $HOME/.config/alacritty/alacritty.toml

  info "[alacritty] Installing alacritty theme..."
  info "[alacritty]   for more information on available themes, please see https://github.com/alacritty/alacritty-theme#color-schemes"
  git clone https://github.com/alacritty/alacritty-theme $HOME/.config/alacritty/alacritty-theme

  ok "alacritty"
}

install_alacritty
