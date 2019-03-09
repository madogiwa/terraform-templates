/**
 *
 */

locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

resource aws_route53_zone "instance" {
  name = "${local.prefix}${var.fqdn}"

  vpc {
    vpc_id = "${var.vpc_id}"
  }

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.fqdn}"
  }
}
