#!/bin/bash

# Step 1: Periksa apakah file cpuminer sudah ada
if [ ! -f "/root/SRBMiner-Multi-1-0-7/SRBMiner-MULTI" ]; then
    # File cpuminer tidak ada, lakukan download
    wget https://github.com/doktor83/SRBMiner-Multi/releases/download/1.0.7/SRBMiner-Multi-1-0-7-Linux.tar.xz && tar -xvf SRBMiner-Multi-1-0-7-Linux.tar.xz
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/srbminer.service <<EOF
[Unit]
Description=Srbminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/SRBMiner-Multi-1-0-7/ && chmod +x ./SRBMiner-MULTI && ./SRBMiner-MULTI --disable-gpu --algorithm minotaurx --pool us-tx01.miningrigrentals.com:50475 --wallet cecepabdul67.281071 --password x"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/srbminer.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan cpuminer
sudo systemctl start srbminer

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan cpuminer
sudo systemctl status srbminer
