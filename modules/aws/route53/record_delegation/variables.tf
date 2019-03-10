
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable "parent_zone_id" {
  description = "Parent route53 zone ID"
}

variable "name" {
  description = "Sub domain name"
}

variable "name_servers" {
  description = "Name servers for sub domain"
  type = "list"
}

variable "ttl" {
  description = "TTL"
  default = 172800
}
