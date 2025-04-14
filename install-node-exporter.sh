#!/bin/bash

set -e

NODE_EXPORTER_VERSION="1.9.0"
ARCH="linux-amd64"
DOWNLOAD_URL="https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}.tar.gz"

echo " Downloading Node Exporter v${NODE_EXPORTER_VERSION}..."
wget $DOWNLOAD_URL

echo " Extracting Node Exporter..."
tar xvf node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}.tar.gz

cd node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}

echo " Installing Node Exporter to /usr/local/bin..."
sudo cp node_exporter /usr/local/bin

echo " Creating node_exporter user..."
sudo useradd --no-create-home --shell /bin/false node_exporter || true

echo " Setting ownership..."
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

echo "🧹 Cleaning up..."
cd ..
rm -rf node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}*
 
echo " Creating systemd service file..."
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service > /dev/null
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

echo " Reloading systemd and starting Node Exporter..."
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

echo "✅ Node Exporter is installed and running!"
sudo systemctl status node_exporter --no-pager
