sudo bash -c 'cat > /usr/local/bin/vps-optimize.sh << "EOF"
#!/bin/bash

echo "🚀 Starting VPS optimization for Debian (4GB RAM)..."

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

# 3️⃣ Sysctl tuning (OPTIMIZED FOR 4GB RAM)
cat > /etc/sysctl.d/99-vps-tune.conf << SYSCTL
# === TCP BBR ===
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr

# === TCP Buffer (4GB RAM) ===
net.core.rmem_max = 8388608
net.core.wmem_max = 8388608
net.ipv4.tcp_rmem = 4096 524288 8388608
net.ipv4.tcp_wmem = 4096 524288 8388608

# === TCP Performance ===
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_max_syn_backlog = 4096
net.core.somaxconn = 4096

# === Memory Management ===
vm.swappiness = 10
vm.vfs_cache_pressure = 50
vm.dirty_ratio = 20
vm.dirty_background_ratio = 10

# === File system ===
fs.file-max = 1048576
SYSCTL

sysctl --system

# 4️⃣ File descriptor limits
cat > /etc/security/limits.d/99-vps-limits.conf << LIMITS
* soft nofile 65535
* hard nofile 65535
root soft nofile 65535
root hard nofile 65535
LIMITS

ulimit -n 65535

# 5️⃣ systemd service (safe, no loop)
cat > /etc/systemd/system/vps-optimize.service << SERVICE
[Unit]
Description=VPS Optimization (4GB RAM)
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
echo "🎉 Optimization completed for 4GB VPS!"
echo "ℹ️ Reboot VPS untuk prestasi maksimum."
EOF'

chmod +x /usr/local/bin/vps-optimize.sh
sudo /usr/local/bin/vps-optimize.sh