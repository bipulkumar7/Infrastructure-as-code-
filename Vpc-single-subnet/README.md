```
Manual settings for creating VPC with single public subnet:

	IPv4 CIDR block: 10.0.0.0/16
	IPv6 CIDR block: No IPv6 CIDR Block
	
	VPC name: Mini Labs
	---------------------------
	Public subnet's IPv4 CIDR: 10.0.0.0/24
	Availability Zone: eu-west-1a
	Subnet name: Public subnet
	----------------------------
	Enable DNS hostnames: Yes
	Hardware tenancy: Default

After creating VPC check with following details:

1. Name and the ID of the VPC, created (look in the Name and VPC ID columns).
2. Check Subnets you will see one Public subnet
3. Check Internet Gateways attached with  Mini Labs VPC
4. Check Route Tables. There are two route tables associated with the VPC. Select the custom route table (the Main column displays No), and then choose the Routes tab to display the route information in the details pane: 

	-------------------------------------------------------
```
```
You can explicitly associate a subnet with a particular route table. Otherwise, the subnet is implicitly associated with the main route table. 
```
# Creating Flow logs for VPC
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-01959718004718f58 \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-destination arn:aws:logs:eu-west-1:662288861703:log-group:my-logs \
    --deliver-logs-permission-arn arn:aws:iam::662288861703:role/Flow-Logs-Role \
    --log-format '${version} ${vpc-id} ${subnet-id} ${instance-id} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${tcp-flags} ${type} ${pkt-srcaddr} ${pkt-dstaddr}'

# List out all the Flow log id 
aws ec2 describe-flow-logs --query 'FlowLogs[*].[FlowLogId]' --output text

# Delete the specific Flog log using given Flow log id
aws ec2 describe-flow-logs --query 'FlowLogs[*].[FlowLogId]'  
aws ec2 describe-flow-logs --query 'FlowLogs[*].[FlowLogId]' --output text | xargs -I % sh -c 'aws ec2 delete-flow-logs --flow-log-id  %'

# List out the  VPC with names from a specific region
aws ec2  describe-vpcs  --query "Vpcs[*].{VpcId:VpcId,Name:Tags[?Key=='Name'].Value|[0]}" --output text

# List out the subnet from the given Vpc -id
aws ec2 describe-subnets     --filters "Name=vpc-id,Values=vpc-0693426a971d145b7" --query 'Subnets[].SubnetId[]' --output text

# Creating ec2 instances
aws ec2 run-instances --image-id ami-04137ed1a354f54c4 --count 1 --instance-type t2.micro --key-name "Host computer key" --subnet-id  subnet-0cef04c0042f2d882

# List out the keys
aws ec2 describe-key-pairs

# List out the VPC with respective name
aws ec2  describe-vpcs  --query 'Vpcs[*].{VpcId:VpcId,Name:Tags[?Key==`Name`].Value|[0],CidrBlock:CidrBlock}'



source: 
	https://docs.aws.amazon.com/vpc/latest/userguide/vpc-getting-started.html#getting-started-create-vpc
	https://docs.aws.amazon.com/vpc/latest/userguide/vpc-getting-started.html#getting-started-assign-eip
	https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-cwl.html
	https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/iam-identity-based-access-control-cwl.html
	https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-cwl.html#flow-logs-iam
	https://jmespath.org/specification.html#filter-expressions
        https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-key-pairs.html
        https://aws.amazon.com/blogs/security/granting-permission-to-launch-ec2-instances-with-iam-roles-passrole-permission/
