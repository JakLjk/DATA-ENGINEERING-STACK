#!/bin/bash
if [ ! -d "/opt/hadoop/data/datanode/current" ]; then
    echo "No datanode dir detected"
    echo "Treating as new Hadoop datanode"
    mkdir -p /opt/hadoop/data/datanode
    chown -R hadoop:hadoop /opt/hadoop/data/datanode
    chmod 755 /opt/hadoop/data/datanode
fi
hdfs datanode