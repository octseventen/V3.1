#!/bin/bash
# =========================================
# KYT BOT INSTALLER (FIX UBUNTU 22.04 - STABIL)
# =========================================

domain=$(cat /etc/xray/domain 2>/dev/null)
grenbo="\e[92;1m"
NC='\e[0m'

clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m INSTALL KYT TELEGRAM BOT PANEL (STABLE) \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2

# update & dependencies
echo -e "${grenbo}Updating system & installing dependencies...${NC}"
apt update -y && apt upgrade -y
apt install -y python3 python3-pip git unzip curl

# pastikan python3 ada
if ! command -v python3 >/dev/null 2>&1; then
  echo "Python3 tidak ditemukan. Install manual lalu jalankan ulang."
  exit 1
fi

# stop service lama
systemctl stop kyt 2>/dev/null
rm -rf /usr/bin/kyt /usr/bin/bot /usr/bin/kyt.zip /usr/bin/bot.zip /etc/systemd/system/kyt.service
rm -f /usr/bin/*.session

# download bot files
cd /usr/bin
wget -q https://raw.githubusercontent.com/octseventen/V3.1/main/files/bot.zip
unzip -o bot.zip >/dev/null 2>&1
mv bot/* /usr/bin 2>/dev/null
chmod +x /usr/bin/*
rm -rf bot bot.zip

# download core
wget -q https://raw.githubusercontent.com/octseventen/V3.1/main/files/kyt.zip
unzip -o kyt.zip >/dev/null 2>&1
pip3 install --break-system-packages -r kyt/requirements.txt
pip3 install telethon requests --no-cache-dir --break-system-packages
rm -f kyt.zip

# input konfigurasi bot
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m        ADD BOT CONFIGURATION       \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -e -p "[*] Bot Token : " bottoken
read -e -p "[*] Admin ID  : " admin

mkdir -p /usr/bin/kyt
cat > /usr/bin/kyt/var.txt <<EOF
BOT_TOKEN="$bottoken"
ADMIN="$admin"
DOMAIN="$domain"
PUB=""
HOST=""
EOF

# buat service systemd
cat > /etc/systemd/system/kyt.service << EOF
[Unit]
Description=KYT Telegram Bot Service
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 /usr/bin/kyt/__main__.py
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# enable & start
systemctl daemon-reload
systemctl enable kyt
systemctl restart kyt

# cek status
sleep 2
if systemctl is-active --quiet kyt; then
  echo -e "\n✅ Bot berhasil dijalankan!"
else
  echo -e "\n❌ Bot gagal dijalankan, cek dengan: journalctl -u kyt -f"
fi

echo -e "\n==============================="
echo "Token Bot : $bottoken"
echo "Admin ID  : $admin"
echo "Domain    : $domain"
echo -e "==============================="
echo "Ketik /menu di Telegram untuk membuka panel bot."
