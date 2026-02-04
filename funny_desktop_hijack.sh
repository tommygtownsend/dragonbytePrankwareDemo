#!/usr/bin/env bash
set -e

echo "[*] Installing xpenguins..."
sudo apt install -y xpenguins

echo "[*] Installing cmatrix..."
sudo apt install -y cmatrix

echo "[*] Launching xpenguins and cmatrix..."

# Start penguins
xpenguins >/dev/null 2>&1 &

# Start cmatrix in a terminal if available
if command -v gnome-terminal >/dev/null 2>&1; then
  gnome-terminal -- bash -lc "cmatrix; exec bash" &
elif command -v xterm >/dev/null 2>&1; then
  xterm -e cmatrix &
else
  cmatrix &
fi

echo "[*] Done."
