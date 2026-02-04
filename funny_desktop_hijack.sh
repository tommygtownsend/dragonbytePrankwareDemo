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

#########################################
# FAKE RANSOMWARE WARNING
#########################################

sleep 3
clear

tput setaf 1
tput bold

echo "████████████████████████████████████████████████████"
echo "██                                                ██"
echo "██            ⚠ SYSTEM COMPROMISED ⚠             ██"
echo "██                                                ██"
echo "████████████████████████████████████████████████████"
echo
echo "Your files have been replaced with penguins."
echo
echo "To recover your system, deposit:"
echo
echo "                1 BTC"
echo
echo "Failure to comply will result in system shutdown."
echo
echo "(Classroom Malware Simulation)"
echo
echo "----------------------------------------------------"
echo

tput sgr0

# Countdown
for i in {30..1}; do
    echo -ne "System shutting down in $i seconds...\r"
    sleep 1
done

echo
echo "[!] Initiating shutdown..."

# Real shutdown
sudo shutdown -h now
