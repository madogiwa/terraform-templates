
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable "domain_name" {
  description = "Domain name"
}

variable "zone_id" {
  description = "ID of route53 zone"
}
