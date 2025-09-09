#!/bin/sh

set -e

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%s)"
BACKUP_ANSWER="n"
IOSEVKA_NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Iosevka.tar.xz"
IOSEVKA_NERD_FONT="IosevkaNerdFont-SemiBold.ttf"
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage"
LV_BRANCH="release-1.4/neovim-0.9" 
LV_URL="https://raw.githubusercontent.com/LunarVim/LunarVim/$LV_BRANCH/utils/installer/install.sh"

install_bashrc() {
  rc_file="$PWD/.bashrc"
  source_line="source $rc_file"
  grep -qxF "$source_line" ~/.bashrc || echo "$source_line" >> ~/.bashrc
  source $rc_file
}
echo "Installing .bashrc.."
install_bashrc
echo ""

install_fonts() {
  dst=~/.local/share/fonts
  if [ -f "$dst/$IOSEVKA_NERD_FONT" ]; then
    echo "Fonts are already installed"
    return
  fi

  IOSEVKA_TAR="$PWD/Iosevka.tar.xz"
  wget -nv $IOSEVKA_NERD_FONT_URL -O $IOSEVKA_TAR
  tar -xf $IOSEVKA_TAR $IOSEVKA_NERD_FONT -C $PWD && rm $IOSEVKA_TAR  

  mkdir -p $dst
  mv $PWD/$IOSEVKA_NERD_FONT $dst
}
echo "Installing fonts.."
install_fonts
echo ""

install_nvim() {
  if [ "$(command -v nvim)" ]; then
    if [ "$(nvim --version | head -n 1 | cut -d ' ' -f 2)" = "v0.9.5" ]; then
      echo "Nvim is already installed"
      return
    fi
  fi
  dst=$PWD/.local/bin/nvim
  wget -nv $NEOVIM_URL -O $dst
  chmod 744 $dst
}
echo "Installing nvim.."
install_nvim
echo ""

traverse_and_ln() {
  for file in "$1"/*; do
    dst=~/$file
    if [ -f "$file" ]; then
      if [ -f "$dst" ]; then
        if [ "$BACKUP_ANSWER" = "y" ]; then
          backup=$(dirname "$BACKUP_DIR/${file}")
          mkdir -p $backup
          mv $dst $backup
          echo "File $dst already exists. Made a copy to $BACKUP_DIR"
        else 
          echo "[ERROR] File $dst already exists!"
          continue
        fi
      fi
      ln -s "$PWD/$file" $dst
    elif [ -d "$file" ]; then
      mkdir -p $dst
      traverse_and_ln "$file"
    fi
  done
}

read -p "Do you want to backup existing files? [y/n] " BACKUP_ANSWER

echo "Installing local.."
traverse_and_ln .local
echo ""

echo "Installing config.."
traverse_and_ln .config
echo ""

install_lvim() {
  LV_BRANCH=$LV_BRANCH bash <(curl -s $LV_URL)
  lvim --headless -c 'LvimCacheReset' -c 'qa'
}
read -p "Do you want to install/reinstall lvim? [y/n] " answer
if [ "$answer" = "y" ]; then
  echo "Installing lvim.."
  install_lvim
  echo ""
fi

