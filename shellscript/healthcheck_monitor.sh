DATE=`date +%d-%m-%Y-%H:%M:%S`
URL="https://hooks.slack.com/services/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"
STATUS=$(curl -s -o /dev/null -I -w "%{http_code}" --location --request GET 'https://test.api.kenkohealth.in/api/v1/healthCheck')
if [ "$STATUS" -eq "200" ] ;
then
        echo "Success"
else
        echo "$DATE || `curl -X POST -H 'Content-type: application/json' --data '{"text":"'$DATE'||'$ENV_NAME' Healthcheck Status Code '$STATUS', Restartig Backend "}' $URL`"
        docker ps
fi
