#!/bin/bash

# Step 1: Unduh dan ekstrak file rhminer
wget https://github.com/polyminer1/rhminer/releases/download/2.3b/rhminer.2.3.Linux.CPU_OLDGEN.zip
unzip rhminer.2.3.Linux.CPU_OLDGEN.zip

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/rhminer.service <<EOF
[Unit]
Description=Rhminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root && ./rhminer -v 2 -r 20 -s stratum+tcp://pascal.tucanpool.com:3334 -su 1140649-43.3A5ADE982ACB80C4.cl/ceceptkj67@gmail.com -cpu -cputhreads 1"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/rhminer.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan rhminer
sudo systemctl start rhminer

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan rhminer
sudo systemctl status rhminer
