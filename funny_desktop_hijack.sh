#!/usr/bin/env bash
set -e

# Require GUI (otherwise terminals can't open)
if [[ -z "${DISPLAY:-}" ]]; then
  echo "[!] No GUI session detected. Run this inside the Kali Desktop GUI, not pure SSH TTY."
  exit 1
fi

echo "[*] Installing xpenguins..."
sudo apt install -y xpenguins

echo "[*] Installing cmatrix..."
sudo apt install -y cmatrix

echo "[*] Launching xpenguins..."
xpenguins >/dev/null 2>&1 &

# --- Create temp scripts to avoid quoting issues ---
CMX="$(mktemp /tmp/cmx.XXXXXX.sh)"
WRN="$(mktemp /tmp/warn.XXXXXX.sh)"

cat > "$CMX" <<'EOF'
#!/usr/bin/env bash
cmatrix
EOF

cat > "$WRN" <<'EOF'
#!/usr/bin/env bash
sleep 2
clear

tput setaf 1; tput bold
echo "████████████████████████████████████████████████████"
echo "██                                                ██"
echo "██            ⚠ SYSTEM COMPROMISED ⚠             ██"
echo "██                                                ██"
echo "████████████████████████████████████████████████████"
echo
echo "Your files have been replaced with penguins."
echo
echo "Deposit 1 BTC to stop shutdown."
echo
echo "(Classroom Malware Simulation — no wallet, no real payment)"
echo "------------------------------------------------------------"
tput sgr0
echo

for i in {30..1}; do
  echo -ne "System shutting down in $i seconds...\r"
  sleep 1
done
echo
echo "[!] Initiating shutdown..."

sudo shutdown -h now
EOF

chmod +x "$CMX" "$WRN"

# Cleanup temp files on exit (won't run after shutdown, but fine)
trap 'rm -f "$CMX" "$WRN"' EXIT

# --- Open terminal windows (Kali/XFCE first) ---
open_term() {
  local script="$1"

  if command -v xfce4-terminal >/dev/null 2>&1; then
    # Kali default (XFCE)
    xfce4-terminal --disable-server --title="Lab Terminal" --command "bash '$script'" &
  elif command -v gnome-terminal >/dev/null 2>&1; then
    gnome-terminal -- bash "$script" &
  elif command -v qterminal >/dev/null 2>&1; then
    qterminal -e bash "$script" &
  elif command -v konsole >/dev/null 2>&1; then
    konsole -e bash "$script" &
  elif command -v xterm >/dev/null 2>&1; then
    xterm -hold -e bash "$script" &
  else
    echo "[!] No supported terminal emulator found (xfce4-terminal/gnome-terminal/xterm/etc)."
    echo "    Install one: sudo apt install -y xfce4-terminal"
    exit 1
  fi
}

echo "[*] Opening two terminals..."
open_term "$CMX"   # Terminal window 1: cmatrix
open_term "$WRN"   # Terminal window 2: warning + countdown + shutdown

echo "[*] Done. (Two terminals should be open now.)"
