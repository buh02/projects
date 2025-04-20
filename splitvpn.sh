sudo tee /usr/local/bin/vpn-split.sh > /dev/null << 'EOL'
#!/bin/bash
# Script mejorado para split tunneling

# Comprobar si la VPN está conectada
if ifconfig utun4 &>/dev/null; then
    echo "Aplicando split tunneling para VPN (utun4)..."
    
    # Eliminar TODAS las rutas por defecto existentes
    sudo route -n delete default > /dev/null 2>&1
    sudo route -n delete default > /dev/null 2>&1
    
    # Añadir la ruta por defecto a través de tu router local
    sudo route -n add default 192.168.111.1
    
    # Eliminar rutas existentes para rangos de clase A y B (por si acaso)
    sudo route -n delete -net 10.0.0.0/8 > /dev/null 2>&1
    sudo route -n delete -net 172.16.0.0/12 > /dev/null 2>&1
    
    # Añadir rutas específicas para rangos de clase A y clase B por la VPN
    sudo route -n add -net 10.0.0.0/8 -interface utun4
    sudo route -n add -net 172.16.0.0/12 -interface utun4
    
    echo "Split Tunneling aplicado correctamente."
    echo "Todo el tráfico general ahora va por tu conexión local."
    echo "El tráfico hacia redes 10.x.x.x y 172.16-31.x.x va por la VPN."
else
    echo "VPN (utun4) no está conectada"
fi
EOL

sudo chmod +x /usr/local/bin/vpn-split.sh
