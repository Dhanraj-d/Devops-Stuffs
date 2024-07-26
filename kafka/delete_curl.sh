
TPC=$1
DBZM_PORT=$(<dbzm_port.txt)


curl -i -X DELETE \
-H "Accept:application/json" \
-H "Content-Type:application/json" localhost:$DBZM_PORT/connectors/$1
echo
echo