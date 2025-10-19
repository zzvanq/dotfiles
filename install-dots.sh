#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"
cd $SCRIPT_DIR

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%s)"

backup_answer="n"
read -p "Do you want to backup existing files? [y*/n] " backup_answer

process_file() {
  if [ -f "$2" ] || [ -L "$2" ]; then
    if [ "$backup_answer" = "y" ]; then
      backup=$(dirname "$BACKUP_DIR/$1")
      mkdir -p $backup
      mv "$2" $backup
      echo "[WARNING] File $2 already exists. Made a copy to $BACKUP_DIR"
    else 
      echo "[WARNING] File $2 already exists. Skipped."
      return
    fi
  fi
  echo "[OK] File $2 is installed."
  ln -s "$SCRIPT_DIR/$1" "$2"
}

traverse_and_cp() {
  for file in "$1"/*; do
    dst=~/$file
    if [ -f "$file" ]; then
      process_file $file $dst
    elif [ -d "$file" ]; then
      mkdir -p $dst
      traverse_and_cp $file
    fi
  done
}


echo "Installing local.."
traverse_and_cp .local
echo ""

echo "Installing config.."
traverse_and_cp .config
