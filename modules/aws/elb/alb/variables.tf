
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable "name" {
  description = "ALB name"
}

variable "is_internal" {
  description = "Create internal load balancer"
  default = false
}

variable "allow_from_all" {
  description = "Allow access from anywhere"
  default = true
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_ids" {
  description = ""
  type = "list"
}

variable "certificate_arn" {
  description = "ARN of acm managed certification"
}

variable "enable_http_redirection" {
  description = "Enable http to https redirection"
  default = true
}
