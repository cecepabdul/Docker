#!/bin/bash

# Step 1: Periksa apakah file cpuminer sudah ada
if [ ! -f "/root/cpuminer-sse2" ]; then
    # File cpuminer tidak ada, lakukan download
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.33a/cpuminer-opt-linux.tar.gz
    tar -xvf cpuminer-opt-linux.tar.gz
fi

# Step 2: Buat file konfigurasi systemd ytn.service
sudo tee /etc/systemd/system/ytn.service <<EOF
[Unit]
Description=YTN Cpuminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root && chmod +x ./cpuminer-sse2 && ./cpuminer-sse2 -a yespowerr16 -o stratum+tcp://americas.mining-dutch.nl:9987 -u cecepabdul.worker1 -p x"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/ytn.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan ytn
sudo systemctl start ytn

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan ytn
sudo systemctl status ytn
