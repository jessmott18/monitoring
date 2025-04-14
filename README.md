# Monitoring Stack

This repo contains a lightweight monitoring and logging stack using **Prometheus**, **Grafana**, **Loki**, and **Alloy**, plus a script for installing **Node Exporter** on remote servers.

---

## 📦 What's Included

- `docker-compose.yml` – Runs the core stack
- `prometheus.yml` – Prometheus config with custom scrape targets
- `loki-config.yaml` – Loki log storage configuration
- `config.alloy` – Alloy log forwarding setup
- `install-node-exporter.sh` – Shell script to install Node Exporter on any Linux server

---

##  Getting Started (Main Server)

### 1. Clone and enter the directory:

```
git clone https://github.com/jessmott18/monitoring.git 
```

```
cd monitoring
```

To add a new server to collect info from update 'prometheus.yml'

```yaml
  - job_name: "server"
    static_configs:
      - targets: ['serverIP:9100']
```

### Start Everything

```bash
docker compose up -d
```

Access your tools:

- Grafana: [http://\<ServerIP>:3000](http://localhost:3000) (user: `admin`, pass: `admin`)
- Prometheus: http\://\<ServerIP>:9090
- Loki API: [http://\<ServerIP>:3100](http://localhost:3100)

---

##  Install Node Exporter on Target Servers

Run this script on each server you want to monitor:

```bash
wget https://raw.githubusercontent.com/jessmott18/monitoring/main/install-node-exporter.sh
chmod +x install-node-exporter.sh
./install-node-exporter.sh
```

###

---

## 📚 References

- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)
- [Loki](https://grafana.com/oss/loki/)
- [Alloy](https://grafana.com/oss/alloy/)
- [Node Exporter](https://github.com/prometheus/node_exporter)

