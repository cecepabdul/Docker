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
sudo tee /etc/systemd/system/crnc.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/bin/bash -c "/root/cpuminer-opt/cpuminer --algo yespower --param-n 2048 --param-r 32 --param-key \"LTNCGYES\" -o -o us.mining4people.com:4170 -u KPUATJhsGzZXf6CzvZ1JQ7B6c9fE7SRc9A.c -p x"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/crnc.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the miningrig service
sudo systemctl start crnc

# Wait for 10 seconds
sleep 10

# Check the status of the miningrig service
sudo systemctl status crnc
