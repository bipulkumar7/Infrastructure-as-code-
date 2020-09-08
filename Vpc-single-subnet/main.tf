# AWS Credential details
provider "aws" {
  version    = "~> 2.0"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
} # End provider

# Create the VPC
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

# Create VPC public subnet
resource "aws_subnet" "main" {

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

# Create the Internet Gateway
resource "aws_internet_gateway" "main_VPC_GW" {
 vpc_id = aws_vpc.main.id
 tags = {
        Name = "Micro Labs VPC Internet Gateway"
}

}


# Create the Route Table
resource "aws_route_table" "custom_route_table" {
vpc_id = aws_vpc.main.id

 tags = {
        Name = "custom VPC Route Table"
  }
} # end resource

# Associating subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.custom_route_table.id
}

