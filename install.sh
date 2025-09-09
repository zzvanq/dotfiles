#!/bin/sh

set -e

steps=(
  "install_lvim.sh"
  "install_pkgs.sh"
  "install_fonts.sh"
  "install_dots.sh"
  "install_bashrc.sh"
)

for step in "${steps[@]}"; do
  echo ""
  echo "================ Running $step ================"
  bash "$step"
  echo "================ Finished $step ==============="
done
