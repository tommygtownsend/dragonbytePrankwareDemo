#!/usr/bin/env bash
set -e

echo "[*] Starting Kali demo..."

# Require GUI
if [[ -z "$DISPLAY" ]]; then
  echo "[!] No GUI session detected. Run this from Kali Desktop."
  exit 1
fi

# ---- APT FIX BLOCK (added) ----
sudo apt clean
sudo apt update -y

# fix missing Kali repo signing keys
sudo apt install -y kali-archive-keyring

# refresh indexes again (should remove NO_PUBKEY)
sudo apt update -y

# (optional but recommended) bring system in sync so installs don't 404
sudo apt -y full-upgrade
# ---- END APT FIX BLOCK ----

echo "[*] Installing required packages..."
sudo apt install -y \
  xpenguins \
  x11-apps \
  hollywood \
  zenity

echo "[*] Launching demo payloads..."

# Penguins everywhere
(xpenguins >/dev/null 2>&1 &)

# Eyes follow cursor
(xeyes >/dev/null 2>&1 &)

# Hollywood hacker terminal
if command -v gnome-terminal >/dev/null; then
  gnome-terminal -- bash -lc "hollywood; exec bash" &
elif command -v xterm >/dev/null; then
  xterm -e hollywood &
else
  hollywood &
fi

# Zenity popup
zenity --warning \
  --title="⚠️ MALWARE ANALYSIS DEMO ⚠️" \
  --width=420 \
  --text=$'This is a **SAFE CLASSROOM DEMO**.\n\n• No files modified\n• No persistence\n• Snapshot revert to recover\n\nClose to continue.' &

echo "[*] All components running."
echo "[*] Snapshot → chaos → revert."

  --text=$'This is a **SAFE CLASSROOM DEMO**.\n\n• No files modified\n• No persistence\n• Snapshot revert to recover\n\nClose to continue.' &

echo "[*] All components running."
echo "[*] Snapshot → chaos → revert."
