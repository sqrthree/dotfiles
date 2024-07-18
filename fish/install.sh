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

# install fish configurations.
install_fish() {
  install "fish"

  link_file $PWD/config.fish $HOME/.config/fish/config.fish

  ok "zsh"
}

install_fish
