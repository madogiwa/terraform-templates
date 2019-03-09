
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable vpc_id {
  description = "VPC id"
}

variable "region" {
  description = "AWS region"
  default = ""
}

variable "allow_from_all" {
  description = "Allow access from anywhere"
  default = true
}

variable "subnet_ids" {
  description = "Create endpoint in specify subnets"
  type = "list"
}

variable "private_dns_enabled" {
  description = "Overwrite default endpoint url. All service trafic goes to this endpoint"
  default = true
}
