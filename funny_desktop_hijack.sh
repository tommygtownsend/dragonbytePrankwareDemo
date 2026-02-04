#!/usr/bin/env bash
set -e

echo "[*] Installing xpenguins..."
sudo apt install -y xpenguins

echo "[*] Installing cmatrix..."
sudo apt install -y cmatrix

echo "[*] Installing zenity (for fake warning popup)..."
sudo apt install -y zenity

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

#########################################
# FAKE RANSOMWARE WARNING (SAFE / JOKE)
#########################################

sleep 3

zenity --warning \
  --title="⚠ SYSTEM COMPROMISED ⚠" \
  --width=400 \
  --height=200 \
  --text="Your system has been 'compromised'.

All files have been replaced with penguins.

System will 'shutdown' in 30 seconds unless 1 BTC is deposited.

(This is a classroom malware demo — no action required.)" &

echo
echo "############################################"
echo "#  ⚠ FAKE MALWARE DEMO ⚠"
echo "#  System will 'shutdown' in 30 seconds"
echo "#  unless 1 BTC is deposited."
echo "#"
echo "#  (This is a harmless classroom simulation)"
echo "############################################"
echo

# Fake countdown (does NOT shut down)
for i in {30..1}; do
  echo "Fake shutdown in $i seconds..."
  sleep 1
done

echo
echo "[*] Demo complete. No shutdown occurred 😄"
