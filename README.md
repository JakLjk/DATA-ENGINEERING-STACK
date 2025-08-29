# 🚀 Hadoop + Spark Cluster with Docker Compose

[![Hadoop](https://img.shields.io/badge/Hadoop-3.3.5-yellow?logo=apache)](https://hadoop.apache.org/)
[![Spark](https://img.shields.io/badge/Spark-4.0.0-orange?logo=apachespark)](https://spark.apache.org/)
[![Docker Compose](https://img.shields.io/badge/Docker--Compose-Local%20Cluster-green?logo=docker)](https://docs.docker.com/compose/)

This project provides a **local Hadoop HDFS + Apache Spark cluster** using Docker Compose.  
It is meant for **development, testing, and learning**, it is not production ready.

---

## Services

### Hadoop
- **hadoop-namenode** (ports: `9870`) – HDFS master node & UI  
- **hadoop-datanode-1**, **hadoop-datanode-2** – HDFS workers storing blocks  

### Spark
- **spark-master** (ports: `8080`, `7077`) – Spark master node & UI  
- **spark-worker** – Spark worker(s) attached to the cluster  
- **spark-history** (port: `18080`) – Spark History Server for job monitoring  

---

##  Setup & Usage

### 1. Start Hadoop (NameNode + DataNodes)
```bash
make build-docker-image
```
- Spins up Hadoop containers
- Waits until HDFS is healthy and available

### 2. Create Spark filesystem directories in HDFS
```bash
make create-spark-fs
```
Creates:
- `/sparkfs/eventlog` (for Spark event logs, mode 1777)
- `/sparkfs/warehouse` (for Spark SQL, mode 775)

### 3. Start Spark Only (Master, Workers, History Server) [Hadoop has to be alreaty initialised]
```bash
make run-spark
```
- Starts Spark master, 2 workers (`--scale spark-worker=2`), and history server
- Mounts configuration from `./configs/spark/spark-defaults.conf`

### 4. Run full stack (Hadoop + Spark)
```bash
make run
```
After startup, UIs are available:
- Hadoop NameNode UI	http://localhost:9870
- Spark Master UI	http://localhost:8080
- Spark History Server	http://localhost:18080

## Development Commands
### 1. Stop cluster
```bash
make down
```

### 2. Stop and clean all volumes
```bash
make down-clean
```

### 3. Open shell in NameNode
```bash
make dev-hdfs-bash
```

### 4. Run Hadoop only (debug mode)
```bash
make dev-run-hadoop
```

### 5. Run Spark only (debug mode)
```bash
make dev-run-spark
```
# Notes
- Hadoop data is persisted in Docker named volumes (hadoop_namenode, hadoop_datanode_1, hadoop_datanode_2).
- Spark logs and history are stored inside HDFS under /sparkfs/.
- Configurations are mounted from ./configs/.
- You can scale workers easily:
    ```bash
    docker compose up -d --scale spark-worker=3
    ```