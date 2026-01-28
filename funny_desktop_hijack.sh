#!/usr/bin/env bash
set -e

echo "[*] Starting Kali penguin demo..."

# Require GUI
if [[ -z "$DISPLAY" ]]; then
  echo "[!] No GUI session detected. Run this from Kali Desktop."
  exit 1
fi

echo "[*] Cleaning + fixing apt (safe for Kali)..."
sudo apt clean
sudo apt update -y
sudo apt install -y kali-archive-keyring
sudo apt update -y

echo "[*] Installing required packages..."
sudo apt install -y xpenguins hollywood

echo "[*] Launching MAXIMUM penguins..."

# xpenguins:
# -n = number of penguins (there is no hard "max", but 100–200 is chaos without freezing most VMs)
# --ignore-workspace keeps them everywhere
xpenguins -n 150 --ignore-workspace >/dev/null 2>&1 &

echo "[*] Launching hollywood..."

if command -v gnome-terminal >/dev/null 2>&1; then
  gnome-terminal -- bash -lc "hollywood; exec bash" &
elif command -v xterm >/dev/null 2>&1; then
  xterm -e hollywood &
else
  hollywood &
fi

echo "[*] Demo running."
echo "[*] Expect penguin overload + hacker-movie nonsense."

  --text=$'This is a **SAFE CLASSROOM DEMO**.\n\n• No files modified\n• No persistence\n• Snapshot revert to recover\n\nClose to continue.' &

echo "[*] All components running."
echo "[*] Snapshot → chaos → revert."
