

MSK_ARN=$(<_txt/msk_arn.txt)

aws kafka describe-cluster --cluster-arn $MSK_ARN