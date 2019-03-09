
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable vpc_id {
  description = "VPC id"
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
