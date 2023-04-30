#!/bin/bash

# Download docker-compose.yml
curl -o docker-compose.yml https://dimas1.vps.webdock.cloud/file/docker-compose.yml

# Install Docker if not already installed
if ! command -v docker &> /dev/null
then
    echo "Docker not found, installing..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

# Start containers
while getopts "c:" option; do
  case "${option}" in
    c)
      export TOKEN=${OPTARG}
      ;;
    *)
      echo "Usage: $0 -c <TOKEN>"
      exit 1
      ;;
  esac
done

docker-compose up -d

# Display running containers
docker ps

# Get public IP
PUBLIC_IP=$(curl -s https://api.ipify.org)
echo "Public IP address: $PUBLIC_IP"

# Delete script file
rm start.sh
