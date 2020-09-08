
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

You can explicitly associate a subnet with a particular route table. Otherwise, the subnet is implicitly associated with the main route table. 




source: https://docs.aws.amazon.com/vpc/latest/userguide/vpc-getting-started.html#getting-started-create-vpc
	https://docs.aws.amazon.com/vpc/latest/userguide/vpc-getting-started.html#getting-started-assign-eip

