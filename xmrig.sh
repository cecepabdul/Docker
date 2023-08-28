#!/bin/bash

# Step 1: Periksa apakah file xmrig sudah ada
if [ ! -f "/root/xmrig-6.7.0/xmrig" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz
    tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/xmrig.service <<EOF
[Unit]
Description=XMRig Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/xmrig-6.7.0 && ./xmrig -k -a rx/0 --donate-level 1 -o pool.eleneum.org:3355 -u 0x80AFA39159589A888e33d82e195BECc555e6AB83 -p x"
WorkingDirectory=/root/xmrig-6.7.0
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/xmrig.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan xmrig
sudo systemctl start xmrig

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan xmrig
sudo systemctl status xmrig
