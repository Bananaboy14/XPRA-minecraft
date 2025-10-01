#!/bin/bash

# Fix XPRA display scaling issues
# This script adjusts the current XPRA session for better display fitting

echo "🔧 Fixing XPRA display scaling..."

# Check if XPRA session is running
if ! xpra list | grep -q ":100"; then
    echo "❌ No XPRA session found on :100"
    echo "Run ./launch_lunar_xpra.sh first"
    exit 1
fi

echo "📐 Adjusting display settings..."

# Try to set a reasonable desktop size via XPRA control
xpra control :100 scaling auto
xpra control :100 desktop-scaling auto
xpra control :100 resize-display yes

echo "🖥️ Refreshing web client..."
echo ""
echo "Please try these steps in your web browser:"
echo "1. Refresh the XPRA web page (F5)"
echo "2. Try different zoom levels (Ctrl +/- or browser zoom)"
echo "3. Use the XPRA toolbar to adjust scaling:"
echo "   - Click the settings gear icon"
echo "   - Adjust 'Desktop Scaling' to 'Auto' or a smaller percentage"
echo "   - Try 'Quality & Encoding' settings"
echo ""
echo "💡 Alternative: Restart with proper settings:"
echo "   xpra stop :100"
echo "   ./launch_lunar_xpra.sh"
echo ""
echo "✅ Settings applied to current session!"