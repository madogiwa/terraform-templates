
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable cidr_block {
  description = "CIDR block for VPC"
}

variable number_of_subnet {
  description = "Number of subnets"
  default = 2
}

variable newbits {
  description = "Use n bits for subnets prefix"
  default = 4
}

variable name {
  description = "VPC name"
  default = "main"
}

variable single_nat {
  description = "use single NAT Gateway across all private subnets"
  default = true
}
