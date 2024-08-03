#!/bin/bash

echo -e "\n Finding total container logs size"
size=$(du -chb /var/lib/docker/containers/*/*-json.log | grep total | awk '{print $1}')
echo -e "\n Total log size is $size bytes"

if [[ $size -gt 20000000 ]]
then
echo -e "\n Flushing container logs"
truncate -s 0 /var/lib/docker/containers/*/*-json.log
else
echo -e "\n Exiting: As logs size less than 20M \n"
fi
