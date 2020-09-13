# 1. AWS Credential details
provider "aws" {
  #version    = "~> 2.0"
  #  access_key = var.access_key
  #  secret_key = var.secret_key
  region = var.region
} # End provider

# 2. Create the VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames

  // Give settings for VPC Flow log

  tags = {
    Name = "Micro Labs"
  }
} # End resource

# 3. Create VPC public subnet
resource "aws_subnet" "Public_subnet" {

  vpc_id = aws_vpc.main.id

  //The CIDR block for the subnet.
  cidr_block = var.subnetCIDRblock

  map_public_ip_on_launch = "true"
  /* Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is False  */

  tags = {
    Name     = "Public subnet"
    Location = "Ireland"
  }
} # End resource

# 4. Create the Internet Gateway
resource "aws_internet_gateway" "main_VPC_GW" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Micro Labs VPC Internet Gateway"
  }

}

# 5. Create the Route Table
resource "aws_route_table" "custom_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_VPC_GW.id
  }

  tags = {
    Name = "custom VPC Route Table"
  }
} # end resource

# 6. Associating subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Public_subnet.id
  route_table_id = aws_route_table.custom_route_table.id
}

# 7. Launching ec2 instance
resource "aws_instance" "node" {
  ami           = "ami-04137ed1a354f54c4"
  instance_type = "t3.micro"
  key_name      = "Host computer key"
  subnet_id     = aws_subnet.Public_subnet.id
  tags = {
    Name = "node0"
  }
}

# 8.  Creating security group & allowing SSH
resource "aws_default_security_group" "SSH" {
  # name        = "SSH"
  # description = "Allow SSH inbound traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  } // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}

# 9. aws flow log
resource "aws_flow_log" "Flow_log" {
  iam_role_arn             = "arn:aws:iam::662288861703:role/Flow-Logs-Role"
  log_destination          = "arn:aws:logs:eu-west-1:662288861703:log-group:my-logs"
  traffic_type             = "ALL"
  max_aggregation_interval = "60"
  #eni_id -
  subnet_id = aws_subnet.Public_subnet.id
  # vpc_id    = aws_vpc.main.id
}

# 10. Creating my-logs at aws_cloudwatch_log_group
resource "aws_cloudwatch_log_group" "my-logs" {
  name = "my-logs"
}

