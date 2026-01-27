sudo bash -c 'cat > /usr/local/bin/vps-optimize.sh << "EOF"
#!/bin/bash

echo "🚀 Starting VPS optimization for Debian (8GB RAM)..."

# Pastikan root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Sila jalankan sebagai root"
  exit 1
fi

# 1️⃣ Update system
apt update -y

# 2️⃣ Enable TCP BBR
modprobe tcp_bbr
echo "tcp_bbr" > /etc/modules-load.d/bbr.conf

# 3️⃣ Sysctl tuning (OPTIMIZED FOR 8GB RAM)
cat > /etc/sysctl.d/99-vps-tune.conf << SYSCTL
# ===============================
# TCP Congestion Control (BBR)
# ===============================
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr

# ===============================
# TCP Buffer (8GB RAM)
# ===============================
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 1048576 16777216
net.ipv4.tcp_wmem = 4096 1048576 16777216

# ===============================
# High Connection Performance
# ===============================
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_max_syn_backlog = 8192
net.core.somaxconn = 8192
net.ipv4.tcp_syncookies = 1

# ===============================
# Memory Management
# ===============================
vm.swappiness = 5
vm.vfs_cache_pressure = 50
vm.dirty_ratio = 20
vm.dirty_background_ratio = 10

# ===============================
# File System
# ===============================
fs.file-max = 2097152
SYSCTL

sysctl --system

# 4️⃣ File descriptor limits
cat > /etc/security/limits.d/99-vps-limits.conf << LIMITS
* soft nofile 131072
* hard nofile 131072
root soft nofile 131072
root hard nofile 131072
LIMITS

ulimit -n 131072

# 5️⃣ systemd service (safe & clean)
cat > /etc/systemd/system/vps-optimize.service << SERVICE
[Unit]
Description=VPS Optimization (8GB RAM)
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/true
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reload
systemctl enable vps-optimize.service

# 6️⃣ Verification
echo
echo "✅ BBR status:"
sysctl net.ipv4.tcp_congestion_control
lsmod | grep bbr || echo "BBR not loaded"

echo
echo "🎉 Optimization completed for 8GB VPS!"
echo "ℹ️ Reboot VPS untuk prestasi maksimum."
EOF'

chmod +x /usr/local/bin/vps-optimize.sh
sudo /usr/local/bin/vps-optimize.sh