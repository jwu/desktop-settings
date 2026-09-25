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

# Rime Ice is a third-party 16 MB release that moves independently of this repo,
# so it is not vendored here. Install it on the first run only, and never clear
# the user directory: *.userdb holds the learned frequency data, which is exactly
# what an update must preserve. See rime/rime-config.md.
RIME_ICE_MIRROR="https://mirror.nju.edu.cn/github-release/iDvel/rime-ice/LatestRelease/full.zip"
RIME_ICE_UPSTREAM="https://github.com/iDvel/rime-ice/releases/latest/download/full.zip"

install_rime_ice() {
  if [ -f "$RIME_DIR/rime_ice.schema.yaml" ]; then
    echo "Rime Ice dictionaries already present."
    return 0
  fi
  local tmp
  tmp="$(mktemp -d)" || return 1
  echo "Downloading Rime Ice dictionaries (~16 MB)..."
  if ! curl -fL --retry 2 -o "$tmp/full.zip" "$RIME_ICE_MIRROR"; then
    if ! curl -fL --retry 2 -o "$tmp/full.zip" "$RIME_ICE_UPSTREAM"; then
      rm -rf "$tmp"
      return 1
    fi
  fi
  if command -v bsdtar &> /dev/null; then
    bsdtar -xf "$tmp/full.zip" -C "$RIME_DIR" || { rm -rf "$tmp"; return 1; }
  elif command -v unzip &> /dev/null; then
    unzip -q -o "$tmp/full.zip" -d "$RIME_DIR" || { rm -rf "$tmp"; return 1; }
  else
    echo "Neither bsdtar nor unzip is available to unpack the archive." >&2
    rm -rf "$tmp"
    return 1
  fi
  rm -rf "$tmp"
  echo "Rime Ice dictionaries installed."
}

if ! command -v fcitx5 &> /dev/null; then
  echo "Error: fcitx5 is not installed."
  exit 1
fi

mkdir -p "$FCITX_CONFIG_DIR/conf" "$FCITX_DATA_DIR/themes/jwu" "$RIME_DIR"

# Dictionaries first: the patches below are applied on top of them, so a future
# release that happens to ship a .custom.yaml cannot overwrite them.
if ! install_rime_ice; then
  echo "Warning: Rime Ice dictionaries were not installed; see rime/rime-config.md." >&2
fi

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
echo "Rime Ice dictionaries are installed on the first run when missing;"
echo "build/ and the user frequency data are never touched."
