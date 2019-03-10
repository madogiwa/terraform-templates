
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

resource aws_route53_record "instance" {
  zone_id = "${var.parent_zone_id}"
  type = "NS"
  name = "${local.prefix}${var.name}"
  records = ["${var.name_servers}"]
  ttl = "${var.ttl}"
}
