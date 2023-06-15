#!/bin/bash

# Mengedit unit file rhminer.service
sudo tee /etc/systemd/system/rhminer.service <<EOF
[Unit]
Description=Rhminer Service
After=network.target

[Service]
ExecStart=/bin/bash -c "cd /root && chmod +x ./rhminer && ./rhminer -v 2 -r 20 -s stratum+tcp://fastpool.xyz:10096 -su 587770-89.0.1/ceceptkj67@gmail.com -cpu"
WorkingDirectory=/root
Restart=always
RestartSec=3
User=root

[Install]
WantedBy=multi-user.target
EOF

# Simpan dan tutup unit file
echo "Unit file updated."

# Perbarui konfigurasi systemd
sudo systemctl daemon-reload

# Mulai ulang layanan rhminer
sudo systemctl restart rhminer

# Beritahu bahwa proses telah selesai
echo "Rhminer service updated and restarted."
