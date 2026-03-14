#!/bin/bash
# ============================================================
#  KDE Create Shortcut - Installer
#  Adds a "Create Shortcut" right-click option in Dolphin
#  No sudo required - installs entirely in your home folder
# ============================================================
set -e
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
echo ""
echo "============================================"
echo "   KDE Create Shortcut - Installer"
echo "============================================"
echo ""
# --- Create directories ---
echo "Creating directories..."
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/kio/servicemenus
# --- Create the helper script ---
echo "Installing helper script to ~/.local/bin/create-shortcut.sh ..."
cat > ~/.local/bin/create-shortcut.sh << 'EOF'
#!/bin/bash
for arg in "$@"; do
  name=$(basename "$arg")
  dest="$(dirname "$arg")/${name}.desktop"

  if [[ "$arg" == *.sh ]]; then
    chmod +x "$arg"
    EXEC_LINE="bash -c \"bash '$arg'; read -p 'Press Enter to close...'\" "
    TERMINAL="true"
  else
    EXEC_LINE="xdg-open '$arg'"
    TERMINAL="false"
  fi

  cat > "$dest" << DESKTOP
[Desktop Entry]
Type=Application
Name=${name} - Shortcut
Exec=${EXEC_LINE}
Icon=unknown
Terminal=${TERMINAL}
StartupNotify=true
DESKTOP

  chmod +x "$dest"
  gio set "$dest" metadata::trusted true
done
EOF
chmod +x ~/.local/bin/create-shortcut.sh
# --- Create the service menu ---
echo "Installing service menu to ~/.local/share/kio/servicemenus/create_shortcut.desktop ..."
cat > ~/.local/share/kio/servicemenus/create_shortcut.desktop << 'EOF'
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=inode/directory;application/octet-stream;
Actions=createDesktopShortcut;
Icon=insert-link
[Desktop Action createDesktopShortcut]
Name=Create Shortcut
Icon=insert-link
Exec=bash -c 'bash ~/.local/bin/create-shortcut.sh "$@"' -- %F
EOF
chmod +x ~/.local/share/kio/servicemenus/create_shortcut.desktop
# --- Restart kded6 ---
echo "Restarting kded6..."
killall kded6 2>/dev/null || true
sleep 1
kded6 > /dev/null 2>&1 &
disown
echo ""
echo -e "${GREEN}Done! Installation complete.${NC}"
echo ""
echo "How to use:"
echo "  1. Right-click any file or folder in Dolphin"
echo "  2. Click 'Create Shortcut'"
echo "  3. A .desktop shortcut is created in the same folder"
echo "  4. Shell scripts (.sh) will automatically execute in a"
echo "     terminal when double-clicked"
echo "  5. To set a custom icon: right-click the shortcut"
echo "     → Properties → click the icon in the top-left"
echo ""
echo "To uninstall, run: bash uninstall.sh"
echo ""
