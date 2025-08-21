run-hadoop:
	docker compose up -d hadoop-datanode-1 hadoop-datanode-2
	until docker exec hadoop-namenode bash -lc 'hdfs dfs -ls / &>/dev/null'; do \
		echo "Waiting for HDFS..."; sleep 1; \
	done

create-spark-fs: run-hadoop
	docker exec hadoop-namenode bash -lc "\
	hdfs dfs -mkdir -p /sparkfs/eventlog && \
	hdfs dfs -chmod -R 1777 /sparkfs/eventlog && \
	hdfs dfs -mkdir -p /sparkfs/warehouse && \
	hdfs dfs -chmod -R 0775 /sparkfs/warehouse \
	"

run-spark: create-spark-fs
	docker compose up -d spark-master spark-worker spark-history --scale spark-worker=2

run-stack: run-spark
	@echo "-------------UI Access-------------"
	@echo "Hadoop NN UI:   http://localhost:9870"
	@echo "Spark Master:   http://localhost:8080"
	@echo "Spark History Server: http://localhost:18080"

down: 
	docker compose down

dev-hdfs-bash:
	docker exec -it hadoop-namenode bash

dev-run-hadoop:
	docker compose up

dev-run-spark:
	docker compose up spark-master spark-worker spark-history

