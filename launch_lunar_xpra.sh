#!/bin/bash

# Launch Lunar Client via XPRA
# This script sets up XPRA server and launches Lunar Client for remote access

echo "Starting Lunar Client via XPRA..."

# Set display variables
export DISPLAY=:100

# Kill any existing XPRA sessions on display :100
echo "Cleaning up any existing XPRA sessions..."
xpra stop :100 2>/dev/null || true

# Wait a moment for cleanup
sleep 2

# Extract AppImage if not already done
if [ ! -d "squashfs-root" ]; then
    echo "Extracting Lunar Client AppImage..."
    ./lunarclient.AppImage --appimage-extract
fi

# Start XPRA server with optimized settings for gaming
echo "Starting XPRA server..."
xpra start :100 \
    --bind-tcp=0.0.0.0:14500 \
    --html=on \
    --start-child="./squashfs-root/lunarclient" \
    --exit-with-children \
    --daemon=no \
    --speaker=on \
    --microphone=on \
    --pulseaudio=yes \
    --clipboard=yes \
    --keyboard-sync=yes \
    --desktop-scaling=auto \
    --resize-display=yes \
    --dpi=96 \
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