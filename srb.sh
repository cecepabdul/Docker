#!/bin/bash

# Step 1: Check if the file /root/SRBMiner-MULTI exists
if [ ! -f "/root/SRBMiner-MULTI" ]; then
    # File SRBMiner-MULTI doesn't exist, perform installation
    wget https://github.com/cecepabdul/Docker/releases/download/1.2/SRBMiner-MULTI -O /root/SRBMiner-MULTI
    chmod +x /root/SRBMiner-MULTI
fi

# Step 2: Create systemd configuration file srb.service
sudo tee /etc/systemd/system/srb.service <<EOF
[Unit]
Description=SRBMiner-MULTI Service
After=network.target

[Service]
ExecStart=/root/SRBMiner-MULTI -a yespowerltncg -o pool.crionic.org:4314 -u KPUATJhsGzZXf6CzvZ1JQ7B6c9fE7SRc9A -p c=CRNC
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Set permissions on the configuration file
sudo chmod 644 /etc/systemd/system/srb.service

# Step 4: Reload systemd configuration
sudo systemctl daemon-reload

# Step 5: Start the srb service
sudo systemctl start srb

# Wait for 10 seconds
sleep 10

# Check the status of the srb service
sudo systemctl status srb
