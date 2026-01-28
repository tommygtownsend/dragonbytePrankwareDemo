#!/usr/bin/env bash
set -e

echo "[*] Starting Kali demo..."

# Require GUI
if [[ -z "$DISPLAY" ]]; then
  echo "[!] No GUI session detected. Run this from Kali Desktop."
  exit 1
fi

echo "[*] Updating repos..."
sudo apt update -y

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

# Zenity "panicware" popup (clearly labeled)
zenity --warning \
  --title="⚠️ MALWARE ANALYSIS DEMO ⚠️" \
  --width=420 \
  --text=$'This is a **SAFE CLASSROOM DEMO**.\n\n• No files modified\n• No persistence\n• Snapshot revert to recover\n\nClose to continue.' &

echo "[*] All components running."
echo "[*] Snapshot → chaos → revert."
