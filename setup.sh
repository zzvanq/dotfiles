#!/bin/sh

IOSEVKA_NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Iosevka.tar.xz"
IOSEVKA_NERD_FONT="IosevkaNerdFont-SemiBold.ttf"
BACKUP_DIR=~/.zzvanq_setup_old

traverse_and_ln() {
  for f in "$1"/*; do
    dst=~/$f
    if [ -f "$f" ]; then
      if [ -f "$dst" ]; then
        backup_dir=$(dirname "$BACKUP_DIR/$(date +%s)/${f}")
        mkdir -p $backup_dir
        mv $dst $backup_dir
        echo "File $dst already exists. Made a copy to $BACKUP_DIR"
      fi
      ln -s "$PWD/$f" $dst
    elif [ -d "$f" ]; then
      mkdir -p $dst
      traverse_and_ln "$f"
    fi
  done
}

echo "Installing tools.."
traverse_and_ln .local
traverse_and_ln .config
echo ""

echo "Installing fonts.."
IOSEVKA_TAR="$PWD/Iosevka.tar.xz"
wget -nv $IOSEVKA_NERD_FONT_URL -O $IOSEVKA_TAR
tar -xf $IOSEVKA_TAR "$IOSEVKA_NERD_FONT"
mkdir -p ~/.local/share/fonts/
mv $PWD/$IOSEVKA_NERD_FONT ~/.local/share/fonts
rm $IOSEVKA_TAR
