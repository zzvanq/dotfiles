#!/bin/sh

set -e

IOSEVKA_NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Iosevka.tar.xz"
IOSEVKA_NERD_FONT="IosevkaNerdFont-SemiBold.ttf"

install_fonts() {
  DST=~/.local/share/fonts
  if [ -f "$DST/$IOSEVKA_NERD_FONT" ]; then
    echo "Fonts are already installed"
    return
  fi

  echo "Installing fonts.."
  IOSEVKA_TAR="$PWD/Iosevka.tar.xz"
  wget -nv $IOSEVKA_NERD_FONT_URL -O $IOSEVKA_TAR
  tar -xf $IOSEVKA_TAR $IOSEVKA_NERD_FONT -C $PWD && rm $IOSEVKA_TAR  

  mkdir -p $DST
  mv $PWD/$IOSEVKA_NERD_FONT $DST
}
install_fonts
