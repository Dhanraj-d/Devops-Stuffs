


KAFKA_DIR=$(<_txt/kafka_scripts_dir.txt)
KAFKA_BROKERS=$(<_txt/kafka_brokers.txt)
ZOOKEEPER_BROKERS=$(<_txt/zookeeper.txt)



echo
$KAFKA_DIR/kafka-topics.sh --list --zookeeper $ZOOKEEPER_BROKERS
echo
