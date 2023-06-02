#!/bin/bash

# Step 1: Periksa apakah file rhminer sudah ada
if [ ! -f "/root/cpuminer-opt-linux/cpuminer-sse2" ]; then
    # File rhminer tidak ada, lakukan download
    wget https://github.com/smectebet/cpuminer-opt-linux/releases/download/5.0.17/cpuminer-opt-linux.tar.gz && tar -xzvf cpuminer-opt-linux.tar.gz
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/rhminer.service <<EOF
[Unit]
Description=Rhminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/cpuminer-opt-linux && ./cpuminer-sse2 -a yespowerr16  -o stratum+tcp://stratum-na.rplant.xyz:3382 -u YiKYmUXmJ4RhjULMpgHMvEtHCHEa4WCYyr.x -p webpassword=cecepabdul,m=solo
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
