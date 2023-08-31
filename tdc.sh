#!/bin/bash

# Step 1: Periksa apakah file cpuminer sudah ada
if [ ! -f "/root/cpuminer-sse2" ]; then
    # File cpuminer tidak ada, lakukan download
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.33a/cpuminer-opt-linux.tar.gz
    tar -xvf cpuminer-opt-linux.tar.gz
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/tdc.service <<EOF
[Unit]
Description=TDC Cpuminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root && chmod +x ./cpuminer-sse2 && ./cpuminer-sse2 -o stratum+tcps://stratum-na.rplant.xyz:17059 -u TY38vT7Ydk6cqcKTq8BNkZLyMJtN9wbNLM.cloud --algo yespowertide -p webpassword=cecepabdul"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/tdc.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan tdc
sudo systemctl start tdc

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan tdc
sudo systemctl status tdc
