#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
NB_BROKERS=$(cat $parent_path/number-br.txt)
BROKER_LIST=$(echo $(for i in $(seq $NB_BROKERS); do echo vkc-br$i:9092','; done)|sed -e 's/,$//g')

if [ $# -gt 0 ]; then
   $KAFKA_HOME/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list $BROKER_LIST --topic $1 --time -1
else
    echo "Usage: "$(basename $0)" <topic_name>"
fi
