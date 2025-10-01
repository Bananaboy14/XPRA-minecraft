#!/bin/bash

# Launch Lunar Client via XPRA with automatic window scaling
echo "🚀 Starting Lunar Client with automatic scaling..."

# Clean up any existing sessions
pkill -f "xpra" 2>/dev/null || true
pkill -f "Xvfb" 2>/dev/null || true
rm -f /tmp/.X*-lock 2>/dev/null || true
rm -rf /home/codespace/.xpra/* 2>/dev/null || true
sleep 3

# Extract AppImage if needed
if [ ! -d "squashfs-root" ]; then
    echo "📦 Extracting Lunar Client AppImage..."
    ./lunarclient.AppImage --appimage-extract
fi

echo "🖥️ Starting XPRA server with automatic scaling..."

# Start XPRA with auto-scaling (single line to avoid parsing issues)
xpra start :400 --bind-tcp=0.0.0.0:14500 --html=on --start-child="./squashfs-root/lunarclient" --exit-with-children --daemon=no --desktop-scaling=auto --resize-display=yes --dpi=96 --speaker=on --microphone=on --pulseaudio=yes --clipboard=yes --keyboard-sync=yes --encoding=png,jpeg,webp --compress=1 --quality=80 --opengl=auto --notifications=yes --cursors=yes --file-transfer=on

echo "🎉 Server ready at http://localhost:14500"
echo "📱 The display will automatically scale to fit your browser window!"