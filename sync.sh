#!/bin/sh

#
# This script is designed to sync local configuration files into current directory,
# so that the changes can be tracked with git.
#

set -e

log () {
  echo "=> $1"
}

log "[vim] sync changes..."
cp ~/.vimrc ./vim/vimrc
log "[vim] done"

log "[nvim] sync changes..."
rm -rf ./nvim
cp -r ~/.config/nvim ./nvim
log "[nvim] ok"
