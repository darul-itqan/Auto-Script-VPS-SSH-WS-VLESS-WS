sudo bash -c 'cat > /usr/local/bin/vps-optimize.sh << "EOF"
#!/bin/bash

echo "🚀 Starting VPS optimization for Debian (1GB RAM / 1 Core)..."

# Pastikan dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Sila jalankan sebagai root"
  exit 1
fi

# 1️⃣ Update package list
apt update -y

# 2️⃣ Enable BBR permanently
modprobe tcp_bbr
echo "tcp_bbr" > /etc/modules-load.d/bbr.conf

# 3️⃣ Sysctl tuning (OPTIMIZED FOR 1GB RAM)
cat > /etc/sysctl.d/99-vps-tune.conf << SYSCTL
# === TCP BBR ===
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr

# === TCP Buffer (1GB RAM safe values) ===
net.core.rmem_max = 4194304
net.core.wmem_max = 4194304
net.ipv4.tcp_rmem = 4096 131072 4194304
net.ipv4.tcp_wmem = 4096 131072 4194304

# === TCP Performance ===
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_fin_timeout = 20
net.ipv4.tcp_max_syn_backlog = 2048
net.core.somaxconn = 2048

# === System Limits ===
fs.file-max = 262144
vm.swappiness = 20
vm.vfs_cache_pressure = 50
SYSCTL

sysctl --system

# 4️⃣ File descriptor limits (safe for 1GB)
cat > /etc/security/limits.d/99-vps-limits.conf << LIMITS
* soft nofile 32768
* hard nofile 32768
root soft nofile 32768
root hard nofile 32768
LIMITS

ulimit -n 32768

# 5️⃣ systemd service (run once, not loop)
cat > /etc/systemd/system/vps-optimize.service << SERVICE
[Unit]
Description=VPS Optimization (1GB RAM)
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

# 6️⃣ Verify
echo
echo "✅ BBR status:"
sysctl net.ipv4.tcp_congestion_control
lsmod | grep bbr || echo "BBR not loaded"

echo
echo "🎉 Optimization completed for 1GB VPS!"
echo "ℹ️ Reboot VPS untuk kesan penuh."
EOF'

chmod +x /usr/local/bin/vps-optimize.sh
sudo /usr/local/bin/vps-optimize.sh