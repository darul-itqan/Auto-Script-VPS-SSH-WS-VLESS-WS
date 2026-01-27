sudo bash -c 'cat > /usr/local/bin/vps-optimize.sh << "EOF"
#!/bin/bash

echo "🚀 Starting VPS optimization for Debian (2GB RAM)..."

# Pastikan root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Sila jalankan sebagai root"
  exit 1
fi

# 1️⃣ Update system
apt update -y

# 2️⃣ Enable BBR
modprobe tcp_bbr
echo "tcp_bbr" > /etc/modules-load.d/bbr.conf

# 3️⃣ Sysctl tuning (OPTIMIZED FOR 2GB RAM)
cat > /etc/sysctl.d/99-vps-tune.conf << SYSCTL
# === TCP BBR ===
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr

# === TCP Buffer (2GB RAM) ===
net.core.rmem_max = 6291456
net.core.wmem_max = 6291456
net.ipv4.tcp_rmem = 4096 262144 6291456
net.ipv4.tcp_wmem = 4096 262144 6291456

# === TCP Performance ===
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_fin_timeout = 20
net.ipv4.tcp_max_syn_backlog = 3072
net.core.somaxconn = 3072

# === System Memory ===
vm.swappiness = 15
vm.vfs_cache_pressure = 50

# === File system ===
fs.file-max = 524288
SYSCTL

sysctl --system

# 4️⃣ File descriptor limits
cat > /etc/security/limits.d/99-vps-limits.conf << LIMITS
* soft nofile 49152
* hard nofile 49152
root soft nofile 49152
root hard nofile 49152
LIMITS

ulimit -n 49152

# 5️⃣ systemd service (safe, no loop)
cat > /etc/systemd/system/vps-optimize.service << SERVICE
[Unit]
Description=VPS Optimization (2GB RAM)
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
echo "🎉 Optimization completed for 2GB VPS!"
echo "ℹ️ Sila reboot VPS untuk kesan penuh."
EOF'

chmod +x /usr/local/bin/vps-optimize.sh
sudo /usr/local/bin/vps-optimize.sh