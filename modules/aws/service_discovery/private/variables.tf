
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable "zone_name" {
  description = "Zone name created by service discovery"
}

variable "vpc_id" {
  description = "VPC id"
}
