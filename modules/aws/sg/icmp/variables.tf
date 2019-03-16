
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "name_prefix" {
  description = "Prefix of security group name"
  default = ""
}

variable "vpc_only" {
  default = false
}

variable "enable_echo" {
  default = true
}

variable "enable_path_mtu_discovery" {
  default = false
}

//variable "enable_ipv6_echo" {
//  default = true
//}
//
//variable "enable_ipv6_path_mtu_discovery" {
//  default = false
//}
