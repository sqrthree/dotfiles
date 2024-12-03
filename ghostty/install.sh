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

# install ghostty configurations.
install_ghostty() {
  install "ghostty"

  mkdir -p $HOME/.config/ghostty
  link_file $PWD/config $HOME/.config/ghostty/config

  ok "ghostty"
}

install_ghostty
