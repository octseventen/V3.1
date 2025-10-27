#!/bin/bash

# =========================================

# KYT BOT INSTALLER (FIX UBUNTU 22.04)

# =========================================

domain=$(cat /etc/xray/domain 2>/dev/null)

# color

grenbo="\e[92;1m"
NC='\e[0m'

clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m INSTALL KYT TELEGRAM BOT PANEL (UBUNTU 22.04 FIX) \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2

# update & install dependencies

echo -e "${grenbo}Updating system & installing dependencies...${NC}"
apt update -y && apt upgrade -y
apt install -y python3 python3-pip git unzip curl jq

if ! command -v python3 >/dev/null 2>&1; then
echo "Python3 not found. Please install manually and rerun."
exit 1
fi

# clean old

systemctl stop kyt 2>/dev/null
rm -rf /usr/bin/kyt /usr/bin/bot /usr/bin/kyt.zip /usr/bin/bot.zip /etc/systemd/system/kyt.service

# download bot files

cd /usr/bin
wget -q [https://raw.githubusercontent.com/octseventen/V3.1/main/files/bot.zip](https://raw.githubusercontent.com/octseventen/V3.1/main/files/bot.zip)
unzip -o bot.zip >/dev/null 2>&1
mv bot/* /usr/bin 2>/dev/null
chmod +x /usr/bin/*
rm -rf bot bot.zip

# download kyt core

wget -q [https://raw.githubusercontent.com/octseventen/V3.1/main/files/kyt.zip](https://raw.githubusercontent.com/octseventen/V3.1/main/files/kyt.zip)
unzip -o kyt.zip >/dev/null 2>&1
pip3 install --break-system-packages -r kyt/requirements.txt
pip3 install telethon requests --no-cache-dir --break-system-packages --target=/usr/local/lib/python3.12/dist-packages
pip3 install telethon requests --no-cache-dir --break-system-packages --target=/usr/lib/python3/dist-packages
rm -f kyt.zip

# ==== Fungsi: List Admin Bot ====

list_admins() {
echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " 📋 \e[1;97;44m LIST ADMIN BOT \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
if [[ ! -f /usr/bin/kyt/var.txt ]]; then
echo "❌ File var.txt belum dibuat."
return
fi
grep '^ADMIN=' /usr/bin/kyt/var.txt | cut -d'"' -f2 | tr ' ' '\n' | nl -w2 -s'. '
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
}

# ==== Fungsi: Tambah Admin Bot ====

add_admin() {
echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ➕ \e[1;97;44m TAMBAH ADMIN BOT \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -e -p "[*] Masukkan ID Telegram Admin Baru: " newadmin

if [[ -z "$newadmin" ]]; then
echo "❌ Tidak boleh kosong."
return
fi

if grep -q "$newadmin" /usr/bin/kyt/var.txt 2>/dev/null; then
echo "⚠️ Admin $newadmin sudah ada."
else
old=$(grep '^ADMIN=' /usr/bin/kyt/var.txt | cut -d'"' -f2)
if [[ -z "$old" ]]; then
echo "ADMIN="$newadmin"" >> /usr/bin/kyt/var.txt
else
echo "ADMIN="$old $newadmin"" > /usr/bin/kyt/var.txt.tmp
mv /usr/bin/kyt/var.txt.tmp /usr/bin/kyt/var.txt
fi
echo "✅ Admin $newadmin berhasil ditambahkan!"
fi
}

# ==== Menu Admin ====

admin_menu() {
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;45m KYT BOT ADMIN MENU \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "1. Lihat daftar admin"
echo "2. Tambah admin baru"
echo "3. Keluar"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -p "Pilih menu [1-3]: " menuopt
case $menuopt in
1) list_admins ;;
2) add_admin ;;
3) return ;;
*) echo "Pilihan tidak valid" ;;
esac
}

# input bot data

clear
echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          ADD BOT PANEL          \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${grenbo}Create Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Create Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -e -p "[*] Input Your Bot Token : " bottoken
read -e -p "[*] Input Your ID Telegram : " admin

mkdir -p /usr/bin/kyt
echo -e BOT_TOKEN='"'$bottoken'"' > /usr/bin/kyt/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/kyt/var.txt

# create systemd service

cat > /etc/systemd/system/kyt.service << END
[Unit]
Description=KYT Telegram Bot Service
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m kyt
Restart=always

[Install]
WantedBy=multi-user.target
END

# start service

systemctl daemon-reload
systemctl enable kyt
systemctl restart kyt

# finish

clear
echo "✅ Installation complete!"
echo "💬 Type /menu on your bot to access the panel."
sleep 2

# tampilkan menu admin opsional

admin_menu
