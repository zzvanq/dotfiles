#!/bin/sh

set -e

function install_pkgs {
  pkgs="$@"
  if [ $(command -v dnf) ]; then
    sudo dnf -y install $pkgs
  elif [ $(command -v apt) ]; then
    sudo apt install -y $pkgs
  elif [ $(command -v pacman) ]; then
    sudo pacman -Sy --noconfirm $pkgs
  else
    echo "No supported package manager found"
    return 1
  fi
}

if [ $(command -v rofi) ]; then
  echo "Rofi is already installed"
  exit 0
fi

echo "Installing rofi.."
install_pkgs rofi
