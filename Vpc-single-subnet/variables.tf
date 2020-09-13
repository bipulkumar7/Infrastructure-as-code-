# variables.tf

# 1   access_key
# variable "access_key" {
#  default = " "
# }

# 2  secret_key
# variable "secret_key" {
#  default = "23n62zuwus0cbXElT1wEjq11sRw6aumObB9LkGm9"
# }

# 3  region
variable "region" {
  default = "eu-west-1"
}

# 4 instanceTenancy
variable "instanceTenancy" {
  default = "default"
}

# 5  vpcCIDRblock
variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}

# 6  dnsSupport
variable "dnsSupport" {
  default = true
}

# 7  dnsHostnames
variable "dnsHostNames" {
  default = true
}

# 8  subnetCIDRblock
variable "subnetCIDRblock" {
  default = "10.0.1.0/24"
}




# end of variables.tf
