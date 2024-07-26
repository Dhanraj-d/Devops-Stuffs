

MSK_ARN=$(<_txt/msk_arn.txt)

aws kafka get-bootstrap-brokers --cluster-arn $MSK_ARN