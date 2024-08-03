#!/bin/bash


DATE=`date +%Y-%m-%d-%H`
RM_DATE=`date -d '-1 day' +%Y-%m-%d`

P=/home/ubuntu/devops/DB_logs

# Declare a string array with type
containerNAME=("mongo1")

for container in ${containerNAME[*]}; do
 echo -e "Taking dump of $container logs"
 logfile=$(docker inspect --format='{{.LogPath}}' $container)
 cat $logfile > $P/$container-$DATE.log
 /usr/local/bin/aws s3 cp $P/$container-$DATE.log s3://kenkohealth-db-logs/mongo-backend/$container/
done

for container in ${containerNAME[*]}; do
if ls $P/$container-$RM_DATE* > /dev/null 2<&1
then
        echo "Deleting logs of $RM_DATE"
        rm $P/$container-$RM_DATE*
else
        ls $P/$container-$RM_DATE*
        echo "No logs Found for $P/$container-$RM_DATE"
fi
done
