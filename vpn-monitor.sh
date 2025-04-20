sudo tee /usr/local/bin/vpn-monitor.sh > /dev/null << 'EOL'
#!/bin/bash

LOG_FILE="/tmp/vpn-monitor.log"
LAST_STATE="disconnected"

echo "$(date): Monitor de VPN iniciado" > "$LOG_FILE"

while true; do
    if ifconfig utun4 &>/dev/null; then
        # La VPN está conectada
        if [ "$LAST_STATE" = "disconnected" ]; then
            echo "$(date): VPN conectada, aplicando split tunneling" >> "$LOG_FILE"
            /usr/local/bin/vpn-split.sh >> "$LOG_FILE" 2>&1
            LAST_STATE="connected"
        fi
    else
        # La VPN está desconectada
        if [ "$LAST_STATE" = "connected" ]; then
            echo "$(date): VPN desconectada" >> "$LOG_FILE"
            LAST_STATE="disconnected"
        fi
    fi
    sleep 5
done
EOL

sudo chmod +x /usr/local/bin/vpn-monitor.sh
