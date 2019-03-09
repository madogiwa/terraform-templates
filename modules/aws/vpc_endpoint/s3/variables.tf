
variable vpc_id {
  description = "VPC id"
}

variable "region" {
  description = "AWS region"
  default = ""
}

variable "route_table_ids" {
  description = "Associate route table IDs"
  type = "list"
}
