#!/bin/bash

# 
sudo apt-get update
sudo apt-get install -y squid

# 
echo "auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd" | sudo tee -a /etc/squid/squid.conf
echo "auth_param basic children 5" | sudo tee -a /etc/squid/squid.conf
echo "auth_param basic realm Squid proxy-caching web server" | sudo tee -a /etc/squid/squid.conf
echo "auth_param basic credentialsttl 2 hours" | sudo tee -a /etc/squid/squid.conf
echo "acl authenticated proxy_auth REQUIRED" | sudo tee -a /etc/squid/squid.conf
echo "http_access allow authenticated" | sudo tee -a /etc/squid/squid.conf
echo "http_port 3128" | sudo tee -a /etc/squid/squid.conf

# 
sudo htpasswd -b -c /etc/squid/passwd cecepabdul Cecepabdul67

# 
sudo service squid restart

# 
sudo ufw allow 3128/tcp
sudo ufw reload
