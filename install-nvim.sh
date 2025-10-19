#!/bin/sh

set -e 

NEOVIM_VERSION="v0.11.4"
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim-linux-x86_64.appimage"

install_nvim() {
  if [ "$(command -v nvim)" ]; then
    if [ "$(nvim --version | head -n 1 | cut -d ' ' -f 2)" = $NEOVIM_VERSION ]; then
      echo "Nvim is already installed"
      return
    fi
  fi
  echo "Installing nvim.."
  DST=$HOME/.local/bin/nvim
  wget -nv $NEOVIM_URL -O $DST
  chmod 744 $DST
}
install_nvim
echo ""

