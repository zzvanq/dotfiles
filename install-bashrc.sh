#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"

install_bashrc() {
  rc_file="$SCRIPT_DIR/.bashrc"
  source_line="source $rc_file"
  grep -qxF "$source_line" ~/.bashrc || echo "$source_line" >> ~/.bashrc
  source $rc_file
}
echo "Installing .bashrc.."
install_bashrc
