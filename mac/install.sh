#!/bin/bash
set -euo pipefail

# ==========================================
# Configuration and Paths
# ==========================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

echo ">>> Starting macOS desktop settings setup..."
echo "    Root Config Dir: $ROOT_DIR"
echo "    Mac Configs Dir: $SCRIPT_DIR"

# ==========================================
# Helpers
# ==========================================

backup_file() {
  if [ -f "$1" ]; then
    echo ">>> Backing up $1 to $1.bak.$TIMESTAMP"
    cp "$1" "$1.bak.$TIMESTAMP"
  fi
}

# ==========================================
# Copy Configurations
# ==========================================

# AeroSpace
echo ">>> Configuring AeroSpace..."
backup_file "$HOME/.aerospace.toml"
cp "$ROOT_DIR/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"

# Zed
echo ">>> Configuring Zed..."
mkdir -p "$HOME/.config/zed"
backup_file "$HOME/.config/zed/settings.json"
cp "$ROOT_DIR/zed/settings.json" "$HOME/.config/zed/settings.json"

# Input Source Pro、Obsidian 和 Total Commander 由应用自行管理，按各自文档手动配置。

if command -v aerospace &> /dev/null; then
  echo ">>> Reloading AeroSpace..."
  aerospace reload-config
fi

echo ">>> Configuration Complete!"
echo "    Restart Zed to apply its settings."
