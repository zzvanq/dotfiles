#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"

steps=(
  "$SCRIPT_DIR/install-nvim.sh"
  "$SCRIPT_DIR/install-pkgs.sh"
  "$SCRIPT_DIR/install-fonts.sh"
  "$SCRIPT_DIR/install-dots.sh"
  "$SCRIPT_DIR/install-bashrc.sh"
)

for step in "${steps[@]}"; do
  echo ""
  echo "================ Running $step ================"
  bash "$step"
  echo "================ Finished $step ==============="
done
