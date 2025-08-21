#!/bin.bash
if [ ! -d "/opt/hadoop/data/namenode/current" ];
then 
echo "No namenode dir detected"
echo "Treating cluster as new Hadooop instance"
echo "Formatting cluster..."
hdfs namenode -format
fi 
echo "Namenode dir detected"
echo "Initialising Hadoop namenode"
hdfs namenode
