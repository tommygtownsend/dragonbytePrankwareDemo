#!/bin/bash

echo "=== Linux Desktop Hijack Demo (Harmless) ==="
echo "This script installs and runs humorous desktop pranks."
echo "Use ONLY inside a VM."
echo

# Detect package manager
if command -v apt >/dev/null 2>&1; then
    PKG_INSTALL="sudo apt install -y"
    PKG_UPDATE="sudo apt update"
elif command -v dnf >/dev/null 2>&1; then
    PKG_INSTALL="sudo dnf install -y"
    PKG_UPDATE="sudo dnf check-update"
else
    echo "Unsupported package manager."
    exit 1
fi

echo "[*] Updating package list..."
$PKG_UPDATE

echo "[*] Installing prank tools..."
$PKG_INSTALL oneko xpenguins xdotool wmctrl x11-apps zenity cmatrix

echo
echo "=== Choose a prank to run ==="
echo "1) oneko (desktop cat chases mouse)"
echo "2) xpenguins (penguins everywhere)"
echo "3) xeyes (eyes follow cursor)"
echo "4) cmatrix (Hollywood hacker terminal)"
echo "5) Mouse hijack (cursor moves on its own)"
echo "6) Fake ransomware popup"
echo "7) RUN ALL (maximum chaos)"
echo "0) Exit"
echo

read -p "Enter choice: " CHOICE

case $CHOICE in
  1)
    oneko &
    ;;
  2)
    xpenguins --transparent &
    ;;
  3)
    xeyes &
    ;;
  4)
    cmatrix
    ;;
  5)
    echo "[!] Press CTRL+C to stop the mouse hijack"
    while true; do
      xdotool mousemove_relative -- 30 0
      sleep 0.3
      xdotool mousemove_relative -- -30 0
      sleep 0.3
    done
    ;;
  6)
    zenity --error \
      --title="SYSTEM COMPROMISED" \
      --text="Your files have been encrypted.\n\nSend 1 BTC to recover them."
    ;;
  7)
    oneko &
    xpenguins --transparent &
    xeyes &
    zenity --warning \
      --title="Warning" \
      --text="Unusual activity detected."
    ;;
  0)
    echo "Exiting."
    exit 0
    ;;
  *)
    echo "Invalid option."
    ;;
esac

echo
echo "=== Demo running ==="
echo "To stop:"
echo "• Close the terminal"
echo "• Or pkill oneko xpenguins xeyes"
echo "• Or revert VM snapshot"
