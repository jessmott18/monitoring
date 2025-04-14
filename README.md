# monitoring-installer
This repo contains a lightweight monitoring and logging stack using Prometheus, Grafana, Loki, and Alloy, plus a script for installing Node Exporter on remote servers.

What's Included: 

docker-compose.yml – Runs the core stack

prometheus.yml – Prometheus config with custom scrape targets

loki-config.yaml – Loki log storage configuration

config.alloy – Alloy log forwarding setup

install-node-exporter.sh – Shell script to install Node Exporter on any Linux server
