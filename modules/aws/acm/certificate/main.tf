
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

resource aws_acm_certificate "instance" {
  domain_name = "${var.domain_name}"
  validation_method = "DNS"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.domain_name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
