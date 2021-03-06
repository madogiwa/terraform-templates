
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
