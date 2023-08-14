#!/bin/bash

# Step 1: Check if the file /root/cpuminer-avx/cpuminer-avx already exists
if [ ! -f "/root/cpuminer-sse2" ]; then
    # File cpuminer-avx doesn't exist, perform installation
    wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.24/cpuminer-opt-linux.tar.gz -O /root/cpuminer-opt-linux.tar.gz
    tar -xvf /root/cpuminer-opt-linux.tar.gz -C /root
fi

# Step 2: Create systemd configuration file miningrig.service
sudo tee /etc/systemd/system/miningrig.service <<EOF
[Unit]
Description=cpuminer-avx Service
After=network.target

[Service]
ExecStart=/root/cpuminer-sse2 -a yespowerltncg -o us-east01.miningrigrentals.com:3333 -u cecepabdul67.291847 -p x
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/miningrig.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the miningrig service
sudo systemctl start miningrig

# Wait for 10 seconds
sleep 10

# Check the status of the miningrig service
sudo systemctl status miningrig
