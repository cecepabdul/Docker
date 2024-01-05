#!/bin/bash

# Step 1: Periksa apakah file packetcrypt-v0.5.2-linux_amd64 sudah ada
if [ ! -f "/root/packetcrypt-v0.5.2-linux_amd64" ]; then
    # File packetcrypt-v0.5.2-linux_amd64 tidak ada, lakukan download
    wget https://www.pkt.world/ext/packetcrypt-linux-amd64 -O packetcrypt
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/packetcrypt.service <<EOF
[Unit]
Description=PacketCrypt Announcer
After=network.target

[Service]
User=root
ExecStart=/bin/bash -c "chmod +x /root/packetcrypt-v0.5.2-linux_amd64 && /root/packetcrypt-v0.5.2-linux_amd64 ann -p pkt1qn8mrx2et6y7u3lv5aejjl7725qt88zyfv5egpf https://stratum.zetahash.com http://pool.pkt.world"
WorkingDirectory=/root
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/packetcrypt.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan packetcrypt
sudo systemctl start packetcrypt

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan packetcrypt
sudo systemctl status packetcrypt
