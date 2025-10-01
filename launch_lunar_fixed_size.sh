#!/bin/bash

# Launch Lunar Client via XPRA with proper display sizing
# This script sets up XPRA server with fixed dimensions to prevent oversized display

echo "🚀 Starting Lunar Client via XPRA with proper display sizing..."

# Set display variables
export DISPLAY=:100

# Kill any existing XPRA sessions on display :100
echo "🧹 Cleaning up any existing XPRA sessions..."
xpra stop :100 2>/dev/null || true

# Wait a moment for cleanup
sleep 2

# Extract AppImage if not already done
if [ ! -d "squashfs-root" ]; then
    echo "📦 Extracting Lunar Client AppImage..."
    ./lunarclient.AppImage --appimage-extract
fi

# Start XPRA server with specific resolution and optimized settings
echo "🖥️ Starting XPRA server with 1280x720 resolution..."
xpra start :100 \
    --bind-tcp=0.0.0.0:14500 \
    --html=on \
    --start-child="./squashfs-root/lunarclient" \
    --exit-with-children \
    --daemon=no \
    --desktop-scaling=1 \
    --resize-display=no \
    --dpi=96 \
    --speaker=on \
    --microphone=on \
    --pulseaudio=yes \
    --clipboard=yes \
    --keyboard-sync=yes \
    --encoding=png,jpeg,rgb \
    --compress=1 \
    --quality=80 \
    --min-quality=30 \
    --speed=80 \
    --min-speed=30 \
    --opengl=auto \
    --notifications=yes \
    --bell=yes \
    --cursors=yes \
    --file-transfer=on \
    --printing=no \
    --webcam=no

echo "XPRA server stopped."