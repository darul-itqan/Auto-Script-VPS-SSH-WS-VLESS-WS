#!/bin/bash
clear

# Update & install package
apt update
apt install wget curl openssl sudo binutils coreutils gnupg bc vnstat -y
apt install sudo -y
apt install htop lsof -y

# Fix Multi Collor
apt install ruby -y
apt install lolcat -y
gem install lolcat

# Fix DNS
cat <(echo "nameserver 103.6.148.6") /etc/resolv.conf > /etc/resolv.conf.tmp && mv /etc/resolv.conf.tmp /etc/resolv.conf && cat <(echo "nameserver 103.6.148.60") /etc/resolv.conf > /etc/resolv.conf.tmp && mv /etc/resolv.conf.tmp /etc/resolv.conf

# Fix Port OpenSSH
cd /etc/ssh
find . -type f -name "*sshd_config*" -exec sed -i 's|#Port 22|Port 22|g' {} +
echo -e "Port 3303" >> sshd_config
cd
systemctl daemon-reload
systemctl restart ssh
systemctl restart sshd

# Make A Directory
mkdir -p /etc/xray/limit/ip/ssh
mkdir -p /etc/xray/limit/ip/vless
mkdir -p /etc/xray/limit/quota/ssh
mkdir -p /etc/xray/limit/database/ssh
mkdir -p /etc/xray/limit/database/vless
mkdir -p /etc/xray/usage/quta/vless
mkdir -p /etc/xray/recovery/ssh
mkdir -p /etc/xray/recovery/vless
mkdir -p /etc/xray/usage/quota/vless

# Copy Menu
cd /usr/local/sbin
apt update
apt install zip unzip -y
wget -qO menu.zip "https://raw.githubusercontent.com/darul-itqan/Auto-Script-VPS-SSH-WS-VLESS-WS/main/menu.zip"
unzip menu.zip
rm -f menu.zip
chmod +x *
cd

# Set Data Domain Server
clear
echo -e "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
            INPUT DOMAIN FOR SERVER
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
"

while true; do
    read -p "Input: " domain
    if [[ -n "$domain" ]]; then
        break
    else
        echo -e "\e[31m[!] Domain wajib diisi. Sila ulangi.\e[0m"
    fi
done

echo -e "\e[32m[OK]\e[0m Domain set -> $domain"

clear
echo -e "$domain" > /etc/xray/domain

# Install Dropbear
apt install dropbear -y
bash <(curl -s https://raw.githubusercontent.com/FN-Rerechan02/tools/refs/heads/main/dropbear.sh)
rm -f /etc/dropbear/dropbear_rsa_host_key
dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
rm -f /etc/dropbear/dropbear_dss_host_key
dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
rm -f /etc/dropbear/dropbear_ecdsa_host_key
dropbearkey -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key
cd /etc/default
rm -f dropbear
wget -qO dropbear "https://codeberg.org/Rerechan02/scvpn/raw/branch/main/files/dropbear"
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
echo -e "Premium VPN" > /etc/issue.net
clear
systemctl daemon-reload
/etc/init.d/dropbear restart
clear
cd /root
rm -fr dropbear*

# Install SSH WebSocket
apt install python3 -y
cd /usr/local/bin
wget -qO proxy "https://raw.githubusercontent.com/darul-itqan/Auto-Script-VPS-SSH-WS-VLESS-WS/main/proxy"
chmod +x proxy
cd /etc/systemd/system
wget -qO ssh-ws.service "https://codeberg.org/Rerechan02/scvpn/raw/branch/main/service/ssh-ws.service"
cd
systemctl daemon-reload
systemctl start ssh-ws.service
systemctl enable ssh-ws.service

# Install BadVPN / UDPGW for Support Call & Video Call
cd /usr/local/bin
wget -qO badvpn "https://codeberg.org/Rerechan02/scvpn/raw/branch/main/biner/badvpn"
chmod +x badvpn
cd /etc/systemd/system
wget -qO badvpn.service "https://codeberg.org/Rerechan02/scvpn/raw/branch/main/service/badvpn.service"
cd
systemctl daemon-reload
systemctl start badvpn.service
systemctl enable badvpn.service

# Install Xray
mkdir -p /usr/local/share/xray
wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
chmod +x /usr/local/share/xray/*
wget -q -O /etc/xray/config.json "https://codeberg.org/Rerechan02/scvpn/raw/branch/main/files/config.json"
cd /etc/xray
uuid=$(cat /proc/sys/kernel/random/uuid)
sed -i "s|xxxxx|${uuid}|g" /etc/xray/config.json
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 25.8.31

# Fix Service Xray
cd /var/log
rm -r xray
mkdir -p xray
sudo chown -R root:root /var/log/xray
sudo touch /var/log/xray/access.log /var/log/xray/error.log
sudo chmod 644 /var/log/xray/*.log
cd /etc/systemd/system
systemctl stop xray.service
systemctl disable xray.service
rm -fr xray*
wget -qO xray.service "https://codeberg.org/Rerechan02/scvpn/raw/branch/main/service/xray.service"
systemctl enable xray
systemctl start xray
systemctl restart xray

# Set
domain=$(cat /etc/xray/domain)

# Nginx & Certificate Setup
apt install socat -y
apt install lsof socat certbot -y
port=$(lsof -i:80 | awk '{print $1}')
systemctl stop apache2
systemctl disable apache2
pkill $port
yes Y | certbot certonly --standalone --preferred-challenges http --agree-tos --email dindaputri@rerechanstore.eu.org -d $domain 
cp /etc/letsencrypt/live/$domain/fullchain.pem /etc/xray/xray.crt
cp /etc/letsencrypt/live/$domain/privkey.pem /etc/xray/xray.key
cd /etc/xray
chmod 644 /etc/xray/xray.key
chmod 644 /etc/xray/xray.crt

# Setup Nginx
bash <(curl -s https://raw.githubusercontent.com/FN-Rerechan02/tools/refs/heads/main/nginx.sh)
systemctl stop nginx
wget -qO /etc/nginx/nginx.conf "https://raw.githubusercontent.com/Rerechan-Team/websocket-proxy/fn_project/nginx.conf"
wget -qO /etc/nginx/fn.conf "https://raw.githubusercontent.com/darul-itqan/Auto-Script-VPS-SSH-WS-VLESS-WS/main/darqan.conf"
sed -i "s|xxx|${domain}|g" /etc/nginx/fn.conf
systemctl daemon-reload
systemctl start nginx

# Buat sijil sementara (self-signed)
sudo mkdir -p /etc/xray
sudo openssl req -x509 -newkey rsa:2048 -days 365 -nodes \
  -keyout /etc/xray/xray.key -out /etc/xray/xray.crt \
  -subj "/CN=localhost"

# Setup Crontab
apt install cron -y

# Setup Auto Backup
echo "* * * * * root xp-ssh" >> /etc/crontab
echo "* * * * * root xp-vless" >> /etc/crontab
echo "0 0 * * * root backup" >> /etc/crontab
echo "0 0 * * * root fixlog" >> /etc/crontab

# restart service
systemctl daemon-relaod
systemctl restart cron

# Install Package Lain
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest

# Setup Limit IP & Quota
cd /etc/systemd/system
wget -q https://codeberg.org/Rerechan02/scvpn/raw/branch/main/service/quota.service
wget -q https://codeberg.org/Rerechan02/scvpn/raw/branch/main/service/limit-ip-vless.service
systemctl daemon-reload
systemctl start quota limit-ip-vless
systemctl enable quota limit-ip-vless
cd

clear
echo -e "clear ; menu" > /root/.profile

# Create Swap RAM
echo -e "Creating Swap Ram"
sh <(curl -s https://raw.githubusercontent.com/FN-Rerechan02/tools/refs/heads/main/swap.sh)
echo -e "Success Create Swap Ram"

# Auto Reboot 5:00AM
bash -c 'apt update -y && apt install -y cron && systemctl enable cron && systemctl start cron && sed -i "/reboot/d" /etc/crontab && echo "0 5 * * * root /sbin/reboot" >> /etc/crontab && systemctl restart cron && echo "✅ Auto reboot set to 5 AM daily"'

# Auto clean log & cache
cat <<'EOF' > /usr/local/bin/autoclean.sh
#!/bin/bash
echo "🧹 Running weekly cleanup..."
apt-get autoremove -y >/dev/null 2>&1
apt-get autoclean -y >/dev/null 2>&1
apt-get clean -y >/dev/null 2>&1
journalctl --vacuum-time=7d >/dev/null 2>&1
rm -rf /tmp/*
rm -rf /var/tmp/*
find /var/log -type f -name "*.log" -mtime +7 -exec rm -f {} \;
echo "🔄 Restarting core services..."
systemctl restart nginx 2>/dev/null
systemctl restart xray 2>/dev/null
systemctl restart ssh 2>/dev/null
systemctl restart stunnel4 2>/dev/null
echo "✅ Cleanup & service restart done at $(date)"
EOF

chmod +x /usr/local/bin/autoclean.sh

(crontab -l 2>/dev/null; echo "0 3 * * 0 /usr/local/bin/autoclean.sh >> /var/log/autoclean.log 2>&1") | crontab -

# BBR Plus & performance tweak
sudo bash -c 'cat > /usr/local/bin/vps-optimize.sh << "EOF"
#!/bin/bash

echo "🚀 Starting VPS optimization..."

# 1️⃣ Pastikan sistem up to date
apt update -y && apt upgrade -y

# 2️⃣ Aktifkan BBR
modprobe tcp_bbr
if ! grep -q "tcp_bbr" /etc/modules-load.d/modules.conf 2>/dev/null; then
  echo "tcp_bbr" >> /etc/modules-load.d/modules.conf
fi

# 3️⃣ Tambah konfigurasi ke sysctl
cat > /etc/sysctl.d/99-vps-tune.conf << SYSCTL
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr

net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216

net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_max_syn_backlog = 4096
net.core.somaxconn = 65535

fs.file-max = 2097152
vm.swappiness = 10
SYSCTL

sysctl --system

# 4️⃣ Tingkatkan limit fail descriptor
cat > /etc/security/limits.d/99-vps-limits.conf << LIMITS
* soft nofile 65535
* hard nofile 65535
root soft nofile 65535
root hard nofile 65535
LIMITS

# 5️⃣ Aktifkan perubahan segera
ulimit -n 65535

# 6️⃣ Semak status BBR
echo
echo "✅ BBR status:"
sysctl net.ipv4.tcp_congestion_control
lsmod | grep bbr || echo "BBR not loaded"

echo
echo "🎉 VPS optimization completed successfully!"
EOF'

chmod +x /usr/local/bin/vps-optimize.sh
sudo /usr/local/bin/vps-optimize.sh

# Notification
echo -e " Script Success Install"
rm -fr *.sh
reboot
