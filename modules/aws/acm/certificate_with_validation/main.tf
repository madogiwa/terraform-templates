
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

resource aws_route53_record "validation" {
  zone_id = "${var.zone_id}"
  name = "${lookup(aws_acm_certificate.instance.domain_validation_options[0], "resource_record_name")}"
  type = "${lookup(aws_acm_certificate.instance.domain_validation_options[0], "resource_record_type")}"
  records = ["${lookup(aws_acm_certificate.instance.domain_validation_options[0], "resource_record_value")}"]
  ttl = 300
}
