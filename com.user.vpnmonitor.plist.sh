cat > ~/Library/LaunchAgents/com.user.vpnmonitor.plist << 'EOL'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.vpnmonitor</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/vpn-monitor.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/vpnmonitor.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/vpnmonitor.err</string>
</dict>
</plist>
EOL

chmod 644 ~/Library/LaunchAgents/com.user.vpnmonitor.plist
