#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"

steps=(
  "$SCRIPT_DIR/install_nvim.sh"
  "$SCRIPT_DIR/install_pkgs.sh"
  "$SCRIPT_DIR/install_fonts.sh"
  "$SCRIPT_DIR/install_dots.sh"
  "$SCRIPT_DIR/install_bashrc.sh"
)

for step in "${steps[@]}"; do
  echo ""
  echo "================ Running $step ================"
  bash "$step"
  echo "================ Finished $step ==============="
done
