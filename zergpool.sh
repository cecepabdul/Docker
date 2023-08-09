#!/bin/bash

# Step 1: Download dan ekstrak SRBMiner-Multi
cd && wget https://github.com/doktor83/SRBMiner-Multi/releases/download/1.0.7/SRBMiner-Multi-1-0-7-Linux.tar.xz && tar -xvf SRBMiner-Multi-1-0-7-Linux.tar.xz && cd SRBMiner-Multi-1-0-7

# Step 2: Buat file konfigurasi systemd zergpool.service
sudo tee /etc/systemd/system/zergpool.service <<EOF
[Unit]
Description=Zergpool Mining Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /path/to/SRBMiner-Multi-1-0-7 && ./SRBMiner-MULTI -a yespowerltncg -o stratum+tcp://yespowerLTNCG.na.mine.zergpool.com:6239 -u TZGQwQ58mdfVg5Tr7ap91pDq4GGARtGYrj --timeout 120 -p c=TRX,mc=CRNC"
WorkingDirectory=/path/to/SRBMiner-Multi-1-0-7
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/zergpool.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan zergpool
sudo systemctl start zergpool

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan zergpool
sudo systemctl status zergpool
