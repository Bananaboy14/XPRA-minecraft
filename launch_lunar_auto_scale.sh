#!/bin/bash

# Launch Lunar Client via XPRA with automatic window scaling
# This script allows XPRA to automatically scale the display to fit your browser window

echo "🚀 Starting Lunar Client via XPRA with automatic window scaling..."

rm -f /tmp/.X200-lock /tmp/.X300-lock 2>/dev/null || true
    --desktop-scaling=33% \
    --resize-display=yes \
#!/usr/bin/env bash

# Robust XPRA launcher for Chromebook-sized clients (1366x768)
# - Starts Xvfb at 1366x768
# - Starts XPRA attached to the Xvfb display
# - Sets desktop-scaling to 0.33 so the rendered desktop fits typical Chromebook viewports
# - Removes unsupported/experimental flags

set -eu
echo "🚀 Launching Lunar Client via XPRA (Chromebook friendly)..."

# Display and ports
XVFB_DISPLAY=":300"
XPRA_PORT=14500
APPDIR="./squashfs-root"
LUNAR_BIN="$APPDIR/lunarclient"

echo "🧹 Cleaning up previous sessions..."
xpra stop ${XVFB_DISPLAY} 2>/dev/null || true
pkill -f "Xvfb.*:300" 2>/dev/null || true
rm -f /tmp/.X300-lock 2>/dev/null || true

sleep 1

if [ ! -d "$APPDIR" ]; then
    echo "📦 Extracting Lunar Client AppImage..."
    ./lunarclient.AppImage --appimage-extract
fi

if [ ! -x "$LUNAR_BIN" ]; then
    echo "❌ Lunar client binary not found or not executable: $LUNAR_BIN"
    exit 1
fi

echo "�️ Starting Xvfb on ${XVFB_DISPLAY} at 1366x768..."
pkill -f "Xvfb.*:300" 2>/dev/null || true
Xvfb ${XVFB_DISPLAY} -screen 0 1366x768x24 &>/tmp/Xvfb-300.log &
XVFB_PID=$!
sleep 0.8

export DISPLAY=${XVFB_DISPLAY}

echo "🛡️ Starting XPRA attached to ${XVFB_DISPLAY} (desktop-scaling=0.33)..."
xpra start ${XVFB_DISPLAY} \
    --use-display=yes \
    --bind-tcp=0.0.0.0:${XPRA_PORT} \
    --html=on \
    --start-child="${LUNAR_BIN}" \
    --exit-with-children \
    --daemon=no \
    --desktop-scaling=0.33 \
    --resize-display=yes \
    --dpi=96 \
    --speaker=on \
    --microphone=on \
    --pulseaudio=yes \
    --clipboard=yes \
    --keyboard-sync=yes \
    --encoding=png,jpeg \
    --compress=1 \
    --quality=80 \
    --opengl=auto \
    --notifications=no \
    --bell=yes \
    --cursors=yes \
    --file-transfer=on \
    --printing=no \
    --webcam=no

echo "✅ XPRA started. Open the web client at: http://localhost:${XPRA_PORT}"

cat <<'INFO'
Quick tips:
- If the page still looks oversized, the browser may request a very large canvas. The script forces the server desktop to 1366x768 and scales the stream to 33%.
- To capture the mouse in the web client for Minecraft, click the pointer-lock / fullscreen icon in the XPRA toolbar (top-left). The web client provides pointer lock controls.
- If you want a different scaling, edit `--desktop-scaling=0.33` to another decimal (e.g. 0.5 for 50%).

Logs:
- Xvfb log: /tmp/Xvfb-300.log
- XPRA sockets: ~/.xpra/
INFO

wait