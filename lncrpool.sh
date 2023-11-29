#!/bin/bash

# Step 1: Check if the file /root/cpuminer-avx/cpuminer-avx already exists
if [ ! -f "/root/cpuminer-sse2" ]; then
    # File cpuminer-avx doesn't exist, perform installation
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.24/cpuminer-opt-linux.tar.gz -O /root/cpuminer-opt-linux.tar.gz
    tar -xvf /root/cpuminer-opt-linux.tar.gz -C /root
fi

# Step 2: Buat file konfigurasi systemd opt.service
sudo tee /etc/systemd/system/lncrpool.service <<EOF
[Unit]
Description=cpuminer-opt Service
After=network.target

[Service]
ExecStart=/root/cpuminer-sse2 -a yespowerltncg -o na.mining4people.com:3384 -u MGUzV5jQZ4YEmsk4QQG4jkQcY5bEbYL4Nc.c -p x
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/lncrpool.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the miningrig service
sudo systemctl start lncrpool

# Wait for 10 seconds
sleep 10

# Check the status of the miningrig service
sudo systemctl status lncrpool
