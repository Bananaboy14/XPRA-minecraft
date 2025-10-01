# XPRA Lunar Client Setup

## 🎮 Complete Setup for Running Lunar Client via XPRA

This setup allows you to run Lunar Client on a GitHub Codespace using XPRA for remote desktop access.

### 📋 What's Included

- **XPRA Server**: Running on display :100 with web interface on port 14500
- **Lunar Client**: Extracted from AppImage and ready to run
- **Audio Support**: PulseAudio configured for game audio
- **Optimized Settings**: Gaming-optimized XPRA configuration

### 🚀 Quick Start

1. **Launch with proper display sizing** (RECOMMENDED):
   ```bash
   ./launch_lunar_fixed_size.sh
   ```

2. **Access via web browser**:
   - Open: http://localhost:14500
   - Click "Connect" when prompted
   - **Display will now fit properly in your browser!**

3. **Alternative launcher** (may have oversized display):
   ```bash
   ./launch_lunar_xpra.sh
   ```

4. **Manual launch** (if needed):
   ```bash
   DISPLAY=:100 ./squashfs-root/lunarclient &
   ```

### 🔧 Management Commands

- **Check status**: `./xpra_info.sh`
- **Stop server**: `xpra stop :100`
- **List sessions**: `xpra list`
- **View logs**: `tail -f /tmp/:100.log`

### 🌐 External Access

For external access (from outside the Codespace):

1. Go to the **Ports** tab in GitHub Codespaces
2. Forward port `14500`
3. Set visibility to **Public** if needed
4. Use the forwarded URL to access Lunar Client

### ⚡ Performance Tips

- The setup uses PNG/JPEG encoding for better compatibility
- Audio is forwarded through PulseAudio
- OpenGL is set to auto-detect
- Desktop scaling is enabled for different screen sizes

### 🐛 Troubleshooting

**If display is oversized/doesn't fit:**
```bash
# Use the fixed-size launcher
xpra stop :100
./launch_lunar_fixed_size.sh
```

**If Lunar Client doesn't appear:**
```bash
# Check if XPRA is running
xpra list

# Check if Lunar Client process is running
ps aux | grep lunar

# Restart everything
xpra stop :100
./launch_lunar_fixed_size.sh
```

**If web interface won't connect:**
```bash
# Check if port is listening
netstat -tlnp | grep 14500

# Check XPRA logs
tail -20 /tmp/:100.log
```

### 📁 File Structure

- `launch_lunar_fixed_size.sh` - **RECOMMENDED launcher** (proper display sizing)
- `launch_lunar_xpra.sh` - Alternative launcher (may have oversized display)
- `fix_display.sh` - Helper script to fix display issues
- `xpra_info.sh` - Status and connection info
- `lunarclient.AppImage` - Original Lunar Client download
- `squashfs-root/` - Extracted AppImage contents
- `/tmp/:100.log` - XPRA server logs

### 🎯 System Requirements Met

✅ **RAM**: 16GB available (Lunar Client needs ~2-4GB)  
✅ **CPU**: 4 cores (sufficient for Minecraft)  
✅ **Storage**: 32GB (Lunar Client ~140MB extracted)  
✅ **Graphics**: Software rendering with OpenGL support  
✅ **Audio**: PulseAudio configured  
✅ **Network**: Port 14500 exposed for web access  

### 🎮 Ready to Play!

Your Lunar Client is now ready to run via XPRA. Simply launch the script and connect via the web interface to start playing Minecraft!
