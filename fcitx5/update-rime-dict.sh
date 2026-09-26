#!/bin/bash
set -euo pipefail

# ==========================================
# Configuration and Paths
# ==========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
RIME_DIR="$HOME/.local/share/fcitx5/rime"

# Rime Ice is not vendored here; pull the rolling "latest" release. The NJU
# mirror is faster from CN and falls back to GitHub. See rime/rime-config.md.
RIME_ICE_MIRROR="https://mirror.nju.edu.cn/github-release/iDvel/rime-ice/LatestRelease/full.zip"
RIME_ICE_UPSTREAM="https://github.com/iDvel/rime-ice/releases/latest/download/full.zip"

# ==========================================
# Helpers
# ==========================================

usage() {
  cat <<'EOF'
Usage: update-rime-dict.sh [--no-deploy]

Refresh the Rime Ice (雾凇拼音) dictionaries in ~/.local/share/fcitx5/rime
from the latest upstream release, re-apply this repo's patches and rebuild.

  (no option)   更新词库 + 重新应用补丁 + 重建并重载
  --no-deploy   只更新词库 + 重新应用补丁，不重建/重载
  -h, --help    显示本帮助
EOF
}

download() {
  local url="$1" out="$2"
  echo ">>> Downloading $url"
  curl -fL --retry 2 --connect-timeout 10 -o "$out" "$url"
}

# ==========================================
# Arguments
# ==========================================

DEPLOY=1
for arg in "$@"; do
  case "$arg" in
    --no-deploy) DEPLOY=0 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; usage >&2; exit 2 ;;
  esac
done

# ==========================================
# Preflight
# ==========================================

if ! command -v fcitx5 &> /dev/null; then
  echo "Error: fcitx5 is not installed." >&2
  exit 1
fi

if command -v bsdtar &> /dev/null; then
  ARCHIVER=bsdtar
elif command -v unzip &> /dev/null; then
  ARCHIVER=unzip
else
  echo "Error: neither bsdtar nor unzip is available; install unzip." >&2
  exit 1
fi

mkdir -p "$RIME_DIR"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# ==========================================
# Download
# ==========================================

if ! download "$RIME_ICE_MIRROR" "$TMP_DIR/full.zip"; then
  echo ">>> Mirror failed; falling back to GitHub."
  download "$RIME_ICE_UPSTREAM" "$TMP_DIR/full.zip"
fi

# ==========================================
# Verify Archive
# ==========================================

if [ "$ARCHIVER" = bsdtar ]; then
  bsdtar -tf "$TMP_DIR/full.zip" > /dev/null
else
  unzip -tq "$TMP_DIR/full.zip" > /dev/null
fi
echo ">>> Archive verified."

# ==========================================
# Back Up User Patches
# ==========================================

# full.zip ships its own *.custom.yaml, so extracting overwrites the patches in
# the user directory. Back them up; install-linux.sh re-applies the repo copies
# below.
shopt -s nullglob
for f in "$RIME_DIR"/*.custom.yaml; do
  echo ">>> Backing up $f to $f.bak.$TIMESTAMP"
  cp -a "$f" "$f.bak.$TIMESTAMP"
done
shopt -u nullglob

# ==========================================
# Extract
# ==========================================

echo ">>> Extracting dictionaries into $RIME_DIR ..."
if [ "$ARCHIVER" = bsdtar ]; then
  bsdtar -xf "$TMP_DIR/full.zip" -C "$RIME_DIR"
else
  unzip -q -o "$TMP_DIR/full.zip" -d "$RIME_DIR"
fi

# ==========================================
# Re-apply Patches / Rebuild
# ==========================================

if [ "$DEPLOY" -eq 1 ]; then
  "$SCRIPT_DIR/install-linux.sh"
else
  cp "$ROOT_DIR/rime/default.custom.yaml" "$RIME_DIR/default.custom.yaml"
  cp "$ROOT_DIR/rime/rime_ice.custom.yaml" "$RIME_DIR/rime_ice.custom.yaml"
  echo ">>> Patches re-applied; deploy skipped (--no-deploy)."
fi

echo ">>> Rime dictionaries updated."
