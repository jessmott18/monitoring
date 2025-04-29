# Monitoring Stack

This repo contains a lightweight monitoring and logging stack using **Prometheus**, **Grafana**, **Loki**, and **Alloy**, plus a script for installing **Node Exporter** on remote servers.

---
## Minimum Server Requirements
CPU cores | 4 to 8+

RAM | 16 GB to 32 GB+

Storage | 200 GB SSD to 500 GB SSD

## Port Requirements
### Minimum Ports To Expose
Required Ports:

  - Grafana: 3000:3000
  - Loki: 3100:3100
  - Prometheus 9100:9100

### If using ufw: 
`sudo ufw allow 3000/tcp`

### Optional Ports (only if you want external access)
If you want to also access the interfaces for debugging or manually checking them:

  - Prometheus UI: 9090

  - Alloy internal server: 12345 (mostly for internal Alloy diagnostics — not needed for normal operation)

  But for basic functionality with Grafana only, you can ignore exposing these.

## Clone and enter the directory:

**Important:** Ensure you are inside the root directory --> /root
``cd root``

```
git clone https://github.com/jessmott18/monitoring.git 
```

```
cd monitoring
```

## What's Included

- `docker-compose.yml` – Runs the core stack

  Within Docker Compose, services can communicate with each other over the internal Docker network by container names (e.g., http://loki:3100).
- `prometheus.yml` – Prometheus config with custom scrape targets
- `loki-config.yaml` – Loki log storage configuration
- `config.alloy` – Alloy log forwarding setup (collection by docker container and directory)
- `install-node-exporter.sh` – Shell script to install Node Exporter on any Linux server

## Recommended File Updates:
Inside `config.alloy`:
```
local.file_match "debug_log" {
  path_targets = [
    --> {__path__ = "/tmp/*.log" },
        {__path__ = "..."},
  ]
}
```
To collect logs by directory/file: **Update** `__path__ = "..."`  line with desired path to directory/files

To add a new server to collect metrics from edit and add this to the end of your 'prometheus.yml'

```yaml
  - job_name: "server"
    static_configs:
      - targets: ['serverIP:9100']
```

## Persistent Storage Setup

Loki needs a writable directory inside the container to keep its index and chunk files. Since we mount a host folder (`./loki-data`) into the container at `/var/loki`, we must:
 **Create the directory on the host**  
   ```
   mkdir -p ./loki-data
  ```

## PostgreSQL
Grafana uses a PostgreSQL database (postgres container) for persistent storage of dashboards, users, and settings. PostgreSQL will automatically be initialized with the credentials provided in docker-compose.yml.

---

##  Getting Started (Main Server)

### Start Everything

```bash
docker compose up -d
```

Access your tools:

- Grafana: http://\<ServerIP>:3000 (user: `admin`, pass: `admin`)
- Prometheus: http\://\<ServerIP>:9090 (optional)
- Loki API: http://\<ServerIP>:3100    (optional)

---

## Access Grafana Dashboard

**Important:** After first login (admin/admin), Grafana will require you to set a new password. Use a strong password immediately to secure the environment.

### Add Prometheus and Loki as Data Sources

Navigate to: **Connections → Data Sources → Add data source**

1. **Prometheus**
    
    - Prometheus Server URL: `http://serverIPrunningPrometheus:9090`
        
2. **Loki**
    
    - Connection URL: `http://serverIPrunningLoki:3100`
        

### Display Metrics

1. Go to **Dashboards** → click **New** → **Import**
    
2. Paste this ID: `1860` and click Load
    
3. Load "Node Exporter" dashboard with datasource prometheus
    
4. Set datasource to **prometheus**
    
5. Switch between jobs in the job dropdown to view metrics from different servers
    

Explore more dashboards here: [Grafana Dashboards](https://grafana.com/grafana/dashboards/)

---

## View Loki Logs

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

