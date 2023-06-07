#!/bin/bash

# Download docker-compose.yml
curl -o docker-compose.yml https://raw.githubusercontent.com/cecepabdul/Docker/main/docker-compose.yml

# Install Docker if not already installed
if ! command -v docker &> /dev/null
then
    echo "Docker not found, installing..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

# Start containers
while getopts "c:e:" option; do
  case "${option}" in
    c)
      export TOKEN=${OPTARG}
      ;;
    e)
      export P2P_EMAIL=${OPTARG}
      ;;
    *)
      echo "Usage: $0 -c <TOKEN> -e <EMAIL>"
      exit 1
      ;;
  esac
done

if [ -z "$TOKEN" ] || [ -z "$P2P_EMAIL" ]
then
    echo "Usage: $0 -c <TOKEN> -e <EMAIL>"
    exit 1
fi

docker-compose up -d

# Display running containers
docker ps

# Get public IP
dig +short myip.opendns.com @resolver1.opendns.com

