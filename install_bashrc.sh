#!/bin/sh

set -e

install_bashrc() {
  rc_file="$PWD/.bashrc"
  source_line="source $rc_file"
  grep -qxF "$source_line" ~/.bashrc || echo "$source_line" >> ~/.bashrc
  source $rc_file
}
echo "Installing .bashrc.."
install_bashrc
