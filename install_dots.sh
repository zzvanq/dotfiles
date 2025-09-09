#!/bin/sh

set -e

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%s)"

backup_answer="n"

traverse_and_ln() {
  for file in "$1"/*; do
    dst=~/$file
    if [ -f "$file" ]; then
      if [ -f "$dst" ]; then
        if [ "$backup_answer" = "y" ]; then
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

read -p "Do you want to backup existing files? [y/n] " backup_answer

echo "Installing local.."
traverse_and_ln .local
echo ""

echo "Installing config.."
traverse_and_ln .config
