/**
 *
 */

data aws_region "current" {}

locals {
  region = "${var.region != "" ? var.region : data.aws_region.current.name}"
}

resource aws_vpc_endpoint "dynamodb" {
  vpc_id = "${var.vpc_id}"
  service_name = "com.amazonaws.${local.region}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids = ["${var.route_table_ids}"]
}
