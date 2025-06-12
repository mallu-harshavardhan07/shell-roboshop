
#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0ac1e9a9f6e09f538"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" 
"payment" "dispatch" "frontend")
ZONE_ID="Z03390001OMXCO0XSJRXF"
DOMAIN_NAME="malluharshavardhanreddy.site"

#  aws ec2 run-instances \
# --image-id ami-09c813fb71547fc4f \
# --instance-type t2.micro \
# --security-group-ids sg-0ac1e9a9f6e09f538 \
# --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"test"}]}'
# --query 'Reservations[*].Instances[0].PrivateIpAddress' \
# --output text


#better code for just creating instance and printing ip adress
# aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids sg-0ac1e9a9f6e09f538  --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"test"}]}' --query 'Instances[0].PrivateIpAddress' --output text


for instance in ${INSTANCES[@]}
do 
   INSTANCE_ID=$(aws ec2 run-instances \
   --image-id ami-09c813fb71547fc4f \
   --instance-type t2.micro \
   --security-group-ids sg-0ac1e9a9f6e09f538 \
   --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"test"}]}'
   --query 'Instances[0].InstanceId' \
   --output text)
   if [ $instance != "frontend" ]
   then
       IP=$(aws ec2 describe-instances --instance-ids i-0123456789abcdef0 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
   else
       IP=$(aws ec2 describe-instances --instance-ids i-0123456789abcdef0 --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
    fi
    echo "$instance IP addre3ss : $IP"
done