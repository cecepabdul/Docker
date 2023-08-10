#!/bin/bash

# Step 1: Periksa apakah file /root/cpuminer-opt/cpuminer sudah ada
if [ ! -f "/root/cpuminer-opt/cpuminer" ]; then
    # File cpuminer belum ada, lakukan instalasi
    sudo apt-get install -y build-essential automake libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev zlib1g-dev git
    git clone https://github.com/JayDDee/cpuminer-opt.git /root/cpuminer-opt
    cd /root/cpuminer-opt
    ./build.sh
fi

# Step 2: Buat file konfigurasi systemd opt.service
sudo tee /etc/systemd/system/opt.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/bin/bash -c "/root/cpuminer-opt/cpuminer --algo yespower --param-n 2048 --param-r 32 --param-key \"LTNCGYES\" -o stratum+tcp://pool.crionic.org:4314 -u KPUATJhsGzZXf6CzvZ1JQ7B6c9fE7SRc9A -p c=CRNC,m=solo"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/opt.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan opt
sudo systemctl start opt

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan opt
sudo systemctl status opt
