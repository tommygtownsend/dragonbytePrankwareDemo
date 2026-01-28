#!/usr/bin/env bash
set -e

echo "[*] Starting Kali demo..."

# Require GUI session
if [[ -z "$DISPLAY" ]]; then
  echo "[!] No GUI session detected. Run this from Kali Desktop."
  exit 1
fi

echo "[*] Cleaning and fixing apt..."
sudo apt clean
sudo apt update -y
sudo apt install -y kali-archive-keyring
sudo apt update -y

echo "[*] Installing required packages..."
sudo apt install -y \
  xpenguins \
  x11-apps \
  cmatrix \
  zenity

echo "[*] Launching demo payloads..."

# MAX penguins (adjust -n higher/lower if needed)
xpenguins -n 150 --ignore-workspace >/dev/null 2>&1 &

# Creepy eyes follow cursor
xeyes >/dev/null 2>&1 &

# Matrix terminal chaos
if command -v gnome-terminal >/dev/null 2>&1; then
  gnome-terminal -- bash -lc "cmatrix; exec bash" &
elif command -v xterm >/dev/null 2>&1; then
  xterm -e cmatrix &
else
  cmatrix &
fi

# Clearly labeled warning popup
zenity --warning \
  --title="⚠️ MALWARE ANALYSIS DEMO ⚠️" \
  --width=450 \
  --text=$'This is a **SAFE CLASSROOM DEMO**.\n\n• No files modified\n• No persistence\n• No real malware\n\nPurpose:\n• Visual chaos\n• User panic simulation\n• Snapshot rollback demo\n\nClose this window to continue.' &

echo "[*] All components launched."
echo "[*] Snapshot → chaos → revert."
