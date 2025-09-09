#!/bin/sh

set -e 

NEOVIM_VERSION="v0.9.5"
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim.appimage"
LV_BRANCH="release-1.4/neovim-0.9" 
LV_URL="https://raw.githubusercontent.com/LunarVim/LunarVim/$LV_BRANCH/utils/installer/install.sh"

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

install_lvim() {
  LV_BRANCH=$LV_BRANCH bash <(curl -s $LV_URL)
  lvim --headless -c 'LvimCacheReset' -c 'qa'
}
read -p "Do you want to install/reinstall lvim? [y/n] " answer
if [ "$answer" = "y" ]; then
  echo "Installing lvim.."
  install_lvim
fi
