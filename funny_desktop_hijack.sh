#!/usr/bin/env bash
set -e

echo "[*] Installing xpenguins..."
sudo apt install -y xpenguins

echo "[*] Installing cmatrix..."
sudo apt install -y cmatrix

echo "[*] Installing zenity..."
sudo apt install -y zenity

echo "[*] Launching programs simultaneously..."

# xpenguins (default behavior)
xpenguins >/dev/null 2>&1 &

# cmatrix (in a terminal if possible)
if command -v gnome-terminal >/dev/null 2>&1; then
  gnome-terminal -- bash -lc "cmatrix; exec bash" &
elif command -v xterm >/dev/null 2>&1; then
  xterm -e cmatrix &
else
  cmatrix &
fi

# zenity warning popup
zenity --warning \
  --title="⚠️ DEMO WARNING ⚠️" \
  --width=420 \
  --text="This is a SAFE classroom demo.\n\nNo files modified.\nNo persistence.\n\nClose to continue." &

echo "[*] Done."
