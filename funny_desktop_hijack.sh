#!/usr/bin/env bash
set -euo pipefail

# Prank/demo launcher (SAFE): xpenguins + xeyes + hollywood + clearly-labeled zenity demo popup
# Tested for Debian/Ubuntu/Kali-ish systems using apt.

need_cmd() { command -v "$1" >/dev/null 2>&1; }

if ! need_cmd apt-get; then
  echo "This script currently supports apt-based distros (Ubuntu/Debian/Kali)."
  exit 1
fi

echo "[*] Updating package lists..."
sudo apt-get update -y

echo "[*] Installing packages..."
# xeyes typically comes from x11-apps
sudo apt-get install -y xpenguins x11-apps zenity hollywood

# Basic "are we in a graphical session?" check.
if [[ -z "${DISPLAY:-}" ]]; then
  echo "[!] DISPLAY is not set. You need to run this inside an X/GUI session (or forwarded X)."
  echo "    Example: run from your desktop terminal, not a pure TTY."
  exit 1
fi

echo "[*] Launching everything..."

# 1) xpenguins (little penguins walking around)
# Some distros provide `xpenguins` directly. If not, try `xpenguins -display :0`.
(xpenguins >/dev/null 2>&1 &)

# 2) xeyes (eyes follow your cursor)
(xeyes >/dev/null 2>&1 &)

# 3) hollywood (terminal "hacker" screens)
# Launch in a new terminal if we can; otherwise run in current terminal.
if need_cmd gnome-terminal; then
  (gnome-terminal -- bash -lc 'hollywood; exec bash' >/dev/null 2>&1 &)
elif need_cmd xterm; then
  (xterm -e bash -lc 'hollywood; exec bash' >/dev/null 2>&1 &)
elif need_cmd konsole; then
  (konsole -e bash -lc 'hollywood; exec bash' >/dev/null 2>&1 &)
else
  echo "[!] No gnome-terminal/xterm/konsole found; running hollywood in THIS terminal."
  hollywood
fi

# 4) Zenity popup (explicitly NOT pretending to be real ransomware)
(zenity --warning \
  --title="TRAINING DEMO (NOT REAL)" \
  --width=420 \
  --text=$'This is a *classroom demo* popup.\n\n✅ NOT ransomware\n✅ No files are touched\n✅ Close this window to continue' \
  >/dev/null 2>&1 &)

echo "[*] Done. Close the popup when you’re ready."
