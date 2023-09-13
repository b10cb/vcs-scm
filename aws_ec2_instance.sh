#!/bin/bash

# Define variables
AMI_ID="ami-0c94855ba95c71c99"    # Amazon Linux 2 AMI (adjust as needed)
INSTANCE_TYPE="t2.micro"
KEY_NAME="your-key-pair-name"
SECURITY_GROUP_ID="sg-0123456789abcdef"  # Replace with your security group ID
SUBNET_ID="subnet-0123456789abcdef"      # Replace with your subnet ID
REGION="us-east-1"

# Run the instance
instance_id=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --region $REGION \
  --query 'Instances[0].InstanceId' \
  --output text
)

# Wait for the instance to be running
aws ec2 wait instance-running --instance-ids $instance_id

# Get the public DNS name of the instance
public_dns=$(aws ec2 describe-instances \
  --instance-ids $instance_id \
  --query 'Reservations[0].Instances[0].PublicDnsName' \
  --output text
)

echo "Instance created successfully with ID: $instance_id"
echo "Public DNS: $public_dns"
