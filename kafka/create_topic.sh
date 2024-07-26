


KAFKA_DIR=$(<_txt/kafka_scripts_dir.txt)
KAFKA_BROKERS=$(<_txt/kafka_brokers.txt)
ZOOKEEPER_BROKERS=$(<_txt/zookeeper.txt)
INPUT_TPC_NAME=$1
INPUT_PARTITIONS=$2
INPUT_REPLICATION_FACTOR=$3
MIN_COUNT_OF_UNDERSCORE_CHARS=3
MAX_ALLOWED_REPLICATION_FACTOR=3
MAX_ALLOWED_PARTITIONS=3



validate_topic_creation_request(){
    echo "validating topic with name = $INPUT_TPC_NAME , partitions = $INPUT_PARTITIONS , replication-factor =  $INPUT_REPLICATION_FACTOR"
    echo

    # check-1 : if topic name or partition or replication factor is not given
    if [[ -z "$INPUT_TPC_NAME"  || -z "$INPUT_PARTITIONS"  ||  -z "$INPUT_REPLICATION_FACTOR" ]];
    then
        echo "ERROR : missing values of topic-name OR partitions-count OR replication-factor"
        exit 1       
    fi

    #check-2 : if replication & partitions are numeric
    re='^[0-9]+$'
    if ! [[ $INPUT_PARTITIONS =~ $re && $INPUT_REPLICATION_FACTOR =~ $re ]];
    then
        echo "ERROR : numeric values expected for partitions-count & replication-factor"
        exit 1       
    fi


    #check-3 : if replication & partitions are within allowed range
    if [[ $INPUT_PARTITIONS <1 || $INPUT_PARTITIONS > $MAX_ALLOWED_PARTITIONS || $INPUT_REPLICATION_FACTOR <1 || $INPUT_REPLICATION_FACTOR > $MAX_ALLOWED_REPLICATION_FACTOR ]];
    then
        echo "ERROR : partitions-count or replication-factor are not within allowed range"
        exit 1       
    fi



    #check-4 : underscore in topic names is not allowed
    underscore_substring="_"
    hyphen_substring="-"
    dot_substring="."
    if [[ $INPUT_TPC_NAME =~ *$dot_substring* || $INPUT_TPC_NAME =~ *$hyphen_substring* ]];
    then
        echo "ERROR : topic name has dot"
        exit 1       
    fi

    #check-5 : topic name must have required number of (.) symbols
    num="${INPUT_TPC_NAME//[^_]}"
    count_underscore_chars=${#num}
    if [[ $MIN_COUNT_OF_UNDERSCORE_CHARS > $count_underscore_chars ]];
    then
        echo "ERROR : topic name has less than minimum required underscore characters"
        exit 1
    fi


    #check-6 : topic name must have all small letters
    # if [[ $INPUT_TPC_NAME =~ [A-Z] ]];
    # then
    #     echo "ERROR : topic name has capital letters"
    #     exit 1
    # fi



    #all validations passed !!
    echo "topic creation request is VALID , now creating topic!!"
    echo
}




echo
# validate_topic_creation_request
$KAFKA_DIR/kafka-topics.sh --create --zookeeper $ZOOKEEPER_BROKERS --topic $INPUT_TPC_NAME --partitions $INPUT_PARTITIONS --replication-factor $INPUT_REPLICATION_FACTOR
echo


