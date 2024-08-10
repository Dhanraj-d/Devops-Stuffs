create cluster

eksctl create cluster --name troposphere-demo --region ap-southeast-1 --version 1.30   --vpc-public-subnets=subnet-04c7c8de8cc3bdcb9,subnet-076e406cf464e79e4 --vpc-private-subnets=subnet-03154c31322b3c1f7,subnet-074d88e096843bb7b --without-nodegroup


worker-nodes-in privatesubnets

eksctl create nodegroup --cluster=troposphere-demo --region=ap-southeast-1 --name=eksdemo1-ng-private1 --node-type=t3.medium --nodes-min=2 --nodes-max=4 --node-volume-size=20  --managed --asg-access  --external-dns-access --appmesh-access --alb-ingress-access --node-private-networking
