#!/bin/bash

# 1. Atualizar e criar 4GB de Swap (Para evitar travamento por falta de RAM)
echo "Iniciando configuração de Swap..."
sudo apt update && sudo apt upgrade -y
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "Swap configurado com sucesso."

# 2. Instalar Docker
echo "Instalando Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
sudo apt install docker-compose -y

# 3. Baixar e Subir Wazuh + n8n
echo "Baixando containers do Wazuh e n8n..."
# n8n
sudo docker run -d --name n8n -p 5678:5678 -e N8N_SECURE_COOKIE=false n8nio/n8n

# Wazuh
git clone https://github.com/wazuh/wazuh-docker.git -b v4.7.5
cd wazuh-docker/single-node
sudo docker-compose -f generate-indexer-certs.yml run --rm generator
sudo docker-compose up -d

echo "Instalação concluída! Acesse o Wazuh via HTTPS e o n8n via HTTP na porta 5678."