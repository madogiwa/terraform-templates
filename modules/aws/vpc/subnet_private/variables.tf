
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable vpc_id {
  description = "VPC id"
}

variable vpc_name {
  description = "VPC name"
}

variable cidr_block {
  description = "CIDR block for subnet"
}

variable ipv6_cidr_block {
  description = "IPv6 CIDR block for subnet"
}

variable number_of_subnet {
  description = "Number of subnets"
  default = 2
}

// aws_eip implicitly depends aws_internet_gateway
variable internet_gateway_id {
  description = "Internet Gateway id"
}

variable nat_subnet_ids {
  description = "ids of public subnets for NAT gateway"
  type = "list"
}

variable single_nat {
  description = "use single NAT Gateway across all private subnets"
  default = true
}
