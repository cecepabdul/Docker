#!/bin/bash

# Buka file .bashrc untuk diedit
bashrc_file="$HOME/.bashrc"

# Periksa apakah /usr/local/bin sudah ada dalam PATH
if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    # Tambahkan /usr/local/bin ke PATH
    echo 'export PATH="$PATH:/usr/local/bin"' >> "$bashrc_file"

    # Muat ulang file .bashrc
    source "$bashrc_file"

    echo "Path /usr/local/bin berhasil ditambahkan ke PATH."
else
    echo "Path /usr/local/bin sudah ada dalam PATH."
fi
