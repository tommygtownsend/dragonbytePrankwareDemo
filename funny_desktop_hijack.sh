#!/usr/bin/env bash
set -e

echo "[*] Installing xpenguins..."
sudo apt install -y xpenguins

echo "[*] Installing cmatrix..."
sudo apt install -y cmatrix

echo "[*] Launching xpenguins (50 penguins)..."
# -n sets number of toons (max 256)  :contentReference[oaicite:1]{index=1}
xpenguins -n 50 -q >/dev/null 2>&1 &

#########################################
# FUNCTION: Open terminal safely (Kali-friendly)
#########################################
open_terminal() {
  if command -v xfce4-terminal >/dev/null 2>&1; then
    xfce4-terminal --disable-server --command "bash -lc '$1'" &
  elif command -v gnome-terminal >/dev/null 2>&1; then
    gnome-terminal -- bash -lc "$1" &
  elif command -v xterm >/dev/null 2>&1; then
    xterm -e "bash -lc '$1'" &
  else
    echo "[!] No GUI terminal found. Running in current shell."
    bash -lc "$1"
  fi
}

#########################################
# TERMINAL 1 — CMATRIX (10s) then WARNING then POWEROFF
#########################################
open_terminal '
set -e
cmatrix >/dev/null 2>&1 &
CM_PID=$!

sleep 10

# Stop cmatrix cleanly
kill "$CM_PID" 2>/dev/null || true
wait "$CM_PID" 2>/dev/null || true

clear
tput setaf 1; tput bold
echo "████████████████████████████████████████████████████"
echo "██                                                ██"
echo "██        ⚠  LAB SIMULATION: SYSTEM COMPROMISED⚠  ██"
echo "██                                                ██"
echo "████████████████████████████████████████████████████"
echo
echo Files have been turned into penguins
echo 
echo Deposit 1btc to get them back!!
echo
echo "This VM will power off in 10 seconds as part of the lab."
echo "Use your snapshot to restore the clean state afterward."
echo
echo "(Classroom demo — not a real infection)"
echo "------------------------------------------------------"
tput sgr0
echo

for i in {10..1}; do
  echo -ne "Powering off in $i seconds...\r"
  sleep 1
done
echo
echo "[!] Powering off now..."
sudo poweroff
'

echo "[*] Demo launched."
