# Monitoring Stack

This repo contains a lightweight monitoring and logging stack using **Prometheus**, **Grafana**, **Loki**, and **Alloy**, plus a script for installing **Node Exporter** on remote servers.

---
## Minimum Server Requirements
Resource | Minimum | Recommended
CPU | 4 vCPU | 8 vCPU
RAM | 16 GB | 32 GB
Storage | 200 GB SSD | 500 GB SSD

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

To add a new server to collect info from edit and add this to the end of your 'prometheus.yml'

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

- Grafana: http://\<ServerIP>:3000 (user: `admin`, pass: `admin`)
- Prometheus: http\://\<ServerIP>:9090
- Loki API: http://\<ServerIP>:3100

---

## Access Grafana Dashboard

### Add Prometheus and Loki as Data Sources

Navigate to: **Connections → Data Sources → Add new data source**

1. **Prometheus**
    
    - Prometheus Server URL: `http://serverIPrunningPrometheus:9090`
        
2. **Loki**
    
    - Connection URL: `http://serverIPrunningLoki:3100`
        

### Display Metrics

1. Go to **Dashboards** → click **New** → **Import**
    
2. Paste this ID: `1860` and click Load
    
3. Load "Node Exporter" dashboard
    
4. Set datasource to **prometheus**
    
5. Switch between jobs in the job dropdown to view metrics from different servers
    

Explore more dashboards here: [Grafana Dashboards](https://grafana.com/grafana/dashboards/)

---

## 6. View Loki Logs

1. Navigate to **Explore → Logs**
    
2. Set datasource to **loki**
    
3. Browse logs by container name from incoming servers

---


##  Install Node Exporter on Target Servers

Run this script on each server you want to monitor:

```bash
wget https://raw.githubusercontent.com/jessmott18/monitoring/main/install-node-exporter.sh
chmod +x install-node-exporter.sh
./install-node-exporter.sh
```
You can disable Node Exporter anytime:

```bash
sudo systemctl disable node_exporter
```



###

---

## 📚 References

- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)
- [Loki](https://grafana.com/oss/loki/)
- [Alloy](https://grafana.com/oss/alloy/)
- [Node Exporter](https://github.com/prometheus/node_exporter)

