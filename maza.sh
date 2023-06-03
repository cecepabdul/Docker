#!/bin/bash

# Step 1: Periksa apakah file cpuminer sudah ada
if [ ! -f "/root/cpuminer-opt-linux/cpuminer-sse2" ]; then
    # File cpuminer tidak ada, lakukan download
    wget https://github.com/smectebet/cpuminer-opt-linux/releases/download/5.0.17/cpuminer-opt-linux.tar.gz && tar -xzvf cpuminer-opt-linux.tar.gz
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/cpuminer.service <<EOF
[Unit]
Description=Cpuminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/cpuminer-opt-linux && ./cpuminer-sse2 -a minotaurx -o stratum+tcp://usa.latinminers.com:9451 -u MLegX9RugBiRMpJjmENLZEtnoPtGrF7o1h.1 -p c=MAZA,m=solo"
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
