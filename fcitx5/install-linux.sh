#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FCITX_CONFIG_DIR="$HOME/.config/fcitx5"
FCITX_DATA_DIR="$HOME/.local/share/fcitx5"
RIME_DIR="$FCITX_DATA_DIR/rime"

backup_file() {
  if [ -f "$1" ]; then
    echo "Backing up $1 to $1.bak.$TIMESTAMP"
    cp "$1" "$1.bak.$TIMESTAMP"
  fi
}

if ! command -v fcitx5 &> /dev/null; then
  echo "Error: fcitx5 is not installed."
  exit 1
fi

mkdir -p "$FCITX_CONFIG_DIR/conf" "$FCITX_DATA_DIR/themes/jwu" "$RIME_DIR"

backup_file "$FCITX_CONFIG_DIR/profile"
cp "$SCRIPT_DIR/profile" "$FCITX_CONFIG_DIR/profile"

backup_file "$FCITX_CONFIG_DIR/conf/classicui.conf"
cp "$SCRIPT_DIR/classicui.conf" "$FCITX_CONFIG_DIR/conf/classicui.conf"

backup_file "$FCITX_DATA_DIR/themes/jwu/theme.conf"
cp "$SCRIPT_DIR/themes/jwu/theme.conf" "$FCITX_DATA_DIR/themes/jwu/theme.conf"

backup_file "$RIME_DIR/default.custom.yaml"
cp "$ROOT_DIR/rime/default.custom.yaml" "$RIME_DIR/default.custom.yaml"
backup_file "$RIME_DIR/rime_ice.custom.yaml"
cp "$ROOT_DIR/rime/rime_ice.custom.yaml" "$RIME_DIR/rime_ice.custom.yaml"

if command -v rime_deployer &> /dev/null && [ -f /usr/share/rime-data/default.yaml ]; then
  rime_deployer --build "$RIME_DIR" /usr/share/rime-data "$RIME_DIR/build"
fi

fcitx5-remote -r 2>/dev/null || true

echo "Fcitx5 configuration installed."
echo "Rime Ice dictionaries and generated build files are left untouched."
