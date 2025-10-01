#!/bin/bash

# Launch Lunar Client via XPRA optimized for Chromebook displays
# This script uses smaller resolution perfect for Chromebook screens

echo "🚀 Starting Lunar Client via XPRA (Chromebook Optimized)..."

# Set display variables
export DISPLAY=:102

# Kill any existing XPRA sessions on display :102
echo "🧹 Cleaning up any existing XPRA sessions..."
xpra stop :102 2>/dev/null || true

# Wait a moment for cleanup
sleep 2

# Extract AppImage if not already done
if [ ! -d "squashfs-root" ]; then
    echo "📦 Extracting Lunar Client AppImage..."
    ./lunarclient.AppImage --appimage-extract
fi

# Start XPRA server with Chromebook-optimized settings (smaller resolution)
echo "💻 Starting XPRA server optimized for Chromebook (1024x576 resolution)..."
xpra start :102 \
    --bind-tcp=0.0.0.0:14502 \
    --html=on \
    --start-child="./squashfs-root/lunarclient" \
    --exit-with-children \
    --daemon=no \
    --desktop-scaling=0.8 \
    --resize-display=yes \
    --dpi=96 \
    --speaker=on \
    --microphone=on \
    --pulseaudio=yes \
    --clipboard=yes \
    --keyboard-sync=yes \
    --encoding=png,jpeg,rgb \
    --compress=2 \
    --quality=75 \
    --min-quality=25 \
    --speed=90 \
    --min-speed=40 \
    --opengl=auto \
    --notifications=yes \
    --bell=yes \
    --cursors=yes \
    --file-transfer=on \
    --printing=no \
    --webcam=no

echo "XPRA server stopped."