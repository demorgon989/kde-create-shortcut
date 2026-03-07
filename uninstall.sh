#!/bin/bash

# ============================================================
#  KDE Create Shortcut - Uninstaller
# ============================================================

set -e

GREEN='\033[0;32m'
NC='\033[0m'

echo ""
echo "============================================"
echo "   KDE Create Shortcut - Uninstaller"
echo "============================================"
echo ""

# --- Remove files ---
echo "Removing helper script..."
rm -f ~/.local/bin/create-shortcut.sh

echo "Removing service menu..."
rm -f ~/.local/share/kio/servicemenus/create_shortcut.desktop

# --- Restart kded6 ---
echo "Restarting kded6..."
killall kded6 2>/dev/null || true
sleep 1
kded6 &
disown

echo ""
echo -e "${GREEN}Done! KDE Create Shortcut has been removed.${NC}"
echo ""
