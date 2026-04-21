SERVICE_DIR="$HOME/.services"
XMRIG_DIR="$SERVICE_DIR/xmrig"
POOL="gulf.moneroocean.stream:10128"
WALLET="48bBiT9hcQqJBZCXxKi6mSTzatRSN7kLMgjTBSQReTN8K7uCzxpn7ZuH7DUXua5uVLj4rRZd7vVXjRTnWEBBE33BC2sdw9k"

echo "Setting up XMRig with your wallet and 15% CPU (1 Thread)..."

# 1. Create Directory
mkdir -p "$XMRIG_DIR"
cd "$XMRIG_DIR"

# 2. Download from your specific link
echo "Downloading from link..."
wget https://raw.githubusercontent.com/followtheyellowbrickroad321/linux-miner/main/xmrig

# 3. Set Permissions
echo "Setting permissions..."
chmod +x xmrig

# 4. Create Auto-Restart Service
echo "Configuring Auto-Restart..."
mkdir -p ~/.config/systemd/user

cat > ~/.config/systemd/user/xmrig.service <<EOF
[Unit]
Description=XMRig Crypto Miner (Static 15%)
After=network.target

[Service]
ExecStart=$XMRIG_DIR/xmrig --url=$POOL --user=$WALLET --cpu=1 --donate-level=1 --nicehash=false --daemon=false --no-color --log-file=/dev/null --bg --threads=1
Restart=always
RestartSec=10

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable xmrig
systemctl --user restart xmrig

echo "Done. Running at 15% (1 Thread) consistently. No more yoyo."
