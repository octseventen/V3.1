#!/bin/bash
#NS=$( cat /etc/xray/dns )
#PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
#color
grenbo="\e[92;1m"
NC='\e[0m'
#install
apt update && apt upgrade
apt install python3 python3-pip git
cd /root
rm -f kyt.sh
cd /usr/bin
rm -f kyt.zip
wget https://raw.githubusercontent.com/octseventen/V3.1/main/files/bot.zip
unzip -o bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
rm -f bot.zip
clear
wget https://raw.githubusercontent.com/octseventen/V3.1/main/files/kyt.zip
unzip -o kyt.zip
pip3 install -r kyt/requirements.txt
rm -f kyt.zip
clear 

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m kyt
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start kyt 
systemctl enable kyt
systemctl restart kyt
cd /usr/bin
rm -f kyt.zip
clear
cd /root
rm -f kyt.sh
