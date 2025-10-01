#!/bin/bash

echo "🧹 Complete cleanup and fresh start..."

# Kill any existing processes
pkill -f "Xvfb" 2>/dev/null || true
pkill -f "xpra" 2>/dev/null || true
pkill -f "lunarclient" 2>/dev/null || true

# Clean up sockets and locks
rm -rf /home/codespace/.xpra/* 2>/dev/null || true
rm -f /tmp/.X*-lock 2>/dev/null || true

sleep 3

echo "🚀 Starting fresh XPRA server on display :200..."

# Start XPRA with a completely fresh display number
xpra start :200 \
  --bind-tcp=0.0.0.0:14500 \
  --html=on \
  --start-child="./squashfs-root/lunarclient" \
  --exit-with-children \
  --daemon=no \
  --desktop-scaling=1 \
  --resize-display=no \
  --dpi=96 \
  --speaker=on --microphone=on --pulseaudio=yes \
  --clipboard=yes --keyboard-sync=yes \
  --encoding=png,jpeg,rgb \
  --compress=2 --quality=75 --min-quality=25 \
  --speed=90 --min-speed=40 \
  --opengl=auto \
  --notifications=yes --bell=yes --cursors=yes \
  --file-transfer=on --printing=no --webcam=no &

echo "🎉 Server starting on port 14500..."
echo "Access at: http://localhost:14500"