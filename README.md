# KDE Create Shortcut

Adds a **"Create Shortcut"** option to the right-click context menu in Dolphin on KDE Plasma 6 (Fedora 43 and other KDE distros).

Works just like "Create Shortcut" on Windows — right-click any file or folder and instantly get a `.desktop` shortcut you can place anywhere.

---

## Features

- Right-click any file or folder → **Create Shortcut**
- Shortcut is a `.desktop` file containing the full path to the original
- Move the shortcut anywhere — it always points back to the original
- Set a custom icon: right-click shortcut → **Properties** → click the icon in the top-left → browse for any PNG
- No sudo required — installs entirely in your home folder
- Includes uninstaller

---

## Requirements

- KDE Plasma 6
- Dolphin file manager
- `kded6` (included with KDE Plasma 6)

---

## Tested On

- Fedora 43 KDE Plasma 6

## May Also Work On

- Kubuntu
- openSUSE KDE
- Arch Linux with KDE Plasma
- Any distro running KDE Plasma 6 with Dolphin

---

## Install

```bash
chmod +x install.sh uninstall.sh && bash install.sh
```

That's it. No sudo, no root, no package manager.

---

## Uninstall

```bash
bash uninstall.sh
```

---

## How it works

The installer creates two files:

- `~/.local/bin/create-shortcut.sh` — the script that generates the `.desktop` shortcut file
- `~/.local/share/kio/servicemenus/create_shortcut.desktop` — registers the right-click menu entry in Dolphin via KIO service menus

---

## Setting a custom icon

1. Right-click the shortcut `.desktop` file
2. Click **Properties**
3. Click the **icon thumbnail** in the top-left of the Properties dialog
4. Browse for any `.png` file on your system

---

## Notes

- Do **not** move or rename the **original file** — the shortcut stores the full path and will break if the original moves (same as Windows)
- The "Create Shortcut" option may also appear when right-clicking empty space in Dolphin — this is a known KDE limitation with directory mime types and is harmless
