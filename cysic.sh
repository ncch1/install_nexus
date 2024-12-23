#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "set restart-required restart" | sudo tee /etc/needrestart/needrestart.conf

sudo apt update && sudo apt upgrade -y

read -p "Введите ваш EVM адрес: " EVM_ADDRESS

curl -L https://github.com/cysic-labs/phase2_libs/releases/download/v1.0.0/setup_linux.sh > ~/setup_linux.sh && bash ~/setup_linux.sh $EVM_ADDRESS

sudo bash -c 'cat > /etc/systemd/system/cysic.service <<EOF
[Unit]
Description=Cysic Verifier Node
After=network.target

[Service]
# Укажите пользователя root
User=root
Group=root

# Установите рабочую директорию
WorkingDirectory=/root/cysic-verifier

# Экспорт переменной окружения и запуск команды
Environment="LD_LIBRARY_PATH=/root/cysic-verifier"
Environment="CHAIN_ID=534352"
ExecStart=/root/cysic-verifier/verifier

# Опции для рестарта
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl daemon-reload
sudo systemctl enable cysic.service
sudo systemctl start cysic.service

sudo journalctl -u cysic.service -f
