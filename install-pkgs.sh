#!/bin/sh

set -e

PKGS_ALL="alacritty rofi rhythmbox"

function install_pkgs {
  pkgs_filtered="$@"
  if [ $(command -v dnf) ]; then
    sudo dnf install  $pkgs_filtered
  elif [ $(command -v pacman) ]; then
    sudo pacman -Sy --noconfirm $pkgs_filtered
  # elif [ $(command -v apt) ]; then
  #   sudo apt install -y $pkgs_filtered
  else
    echo "No supported package manager found"
    return 1
  fi
}

pkgs_filtered=""
for pkg in $PKGS_ALL; do
  if [ $(command -v $pkg) ]; then
    echo "$pkg is already installed"
    continue
  fi
  pkgs_filtered="$pkg $pkgs_filtered"
done

if [ -n "$pkgs_filtered" ]; then
  echo ""
  echo "Installing pkgs: $pkgs_filtered"
  install_pkgs $pkgs_filtered
fi
