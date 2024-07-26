
DBZM_PORT=$(<dbzm_port.txt)


curl -i -X GET \
-H "Accept:application/json" \
-H "Content-Type:application/json" localhost:$DBZM_PORT/connectors
echo
echo