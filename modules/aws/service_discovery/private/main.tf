/**
 *
 */

locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

resource aws_service_discovery_private_dns_namespace "instance" {
  name = "${local.prefix}${var.zone_name}"
  vpc = "${var.vpc_id}"
}
