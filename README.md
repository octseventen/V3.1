

# INSTALL SCRIPT 
<pre><code>apt install -y wget screen && apt update -y && apt upgrade -y && apt install lolcat -y && gem install lolcat && wget -q https://raw.githubusercontent.com/octseventen/V3.1/main/premi.sh && chmod +x premi.sh && screen -S install ./premi.sh
</code></pre>

# INSTALL SCRIPT TANPA INTERAKSI
<pre><code>export DEBIAN_FRONTEND=noninteractive && \
apt update -y && \
apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade -yq && \
apt install -y linux-image-generic linux-headers-generic || { echo "Gagal instal kernel"; exit 1; } && \
apt autoremove --purge -y && apt clean && \
# --- lanjut instal paket & script asli ---
apt install -y wget screen || { echo "Gagal instal wget/screen"; exit 1; } && \
apt update -y && apt upgrade -y && \
apt install -y lolcat ruby-full build-essential || true && \
gem install lolcat || true && \
wget -q https://raw.githubusercontent.com/octseventen/V3.1/main/premi.sh && chmod +x premi.sh && \
screen -S install ./premi.sh</code></pre>

# UPDATE 
<pre><code>wget https://raw.githubusercontent.com/octseventen/V3.1/main/update.sh && chmod +x update.sh && ./update.sh</code></pre>

# SUPPORT OS
- UBUNTU 22.04 ( RECOMENDED )

# NOTE
```
JIKA MENDAPATKAN STATUS SERVICE OFF
BISA RESTERT SERVICE DI MENU
JIKA MASIH OFF SILAHKAN REBOOT VPS 
```
