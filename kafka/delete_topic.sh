


KAFKA_DIR=$(<_txt/kafka_scripts_dir.txt)
KAFKA_BROKERS=$(<_txt/kafka_brokers.txt)
ZOOKEEPER_BROKERS=$(<_txt/zookeeper.txt)
array=( "$@" )
arraylength=${#array[@]}


for (( i=0; i<${arraylength}; i++ )); do
    topic_to_delete=${array[$i]}
    $KAFKA_DIR/kafka-topics.sh --delete --zookeeper $ZOOKEEPER_BROKERS --topic $topic_to_delete
    echo "Deleted topic $topic_to_delete"
    echo
done