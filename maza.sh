#!/bin/bash

# Step 1: Periksa apakah file cpuminer sudah ada
if [ ! -f "/root/cpuminer-sse2" ]; then
    # File cpuminer tidak ada, lakukan download
    wget https://github.com/cecepabdul/Docker/releases/download/1.1/cpuminer-sse2
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/cpuminer.service <<EOF
[Unit]
Description=Srbminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root && chmod +x ./cpuminer-sse2 && ./cpuminer-sse2 -o stratum+tcps://stratum-na.rplant.xyz:17059 -u TY38vT7Ydk6cqcKTq8BNkZLyMJtN9wbNLM.C  --algo yespowertide -p webpassword=cecepabdul"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/cpuminer.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan cpuminer
sudo systemctl start cpuminer

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan cpuminer
sudo systemctl status cpuminer
