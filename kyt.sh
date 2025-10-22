#!/bin/bash
# =========================================
#  KYT BOT INSTALLER (FIX UBUNTU 22.04)
# =========================================

domain=$(cat /etc/xray/domain 2>/dev/null)
grenbo="\e[92;1m"
NC='\e[0m'

clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m INSTALL KYT TELEGRAM BOT PANEL \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

# update & install dependencies
apt update -y && apt upgrade -y
apt install -y python3 python3-pip git unzip curl

# remove old
systemctl stop kyt 2>/dev/null
rm -rf /usr/bin/kyt /usr/bin/bot /etc/systemd/system/kyt.service

# download bot files
cd /usr/bin
wget -q https://raw.githubusercontent.com/octseventen/V3.1/main/files/bot.zip
