
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

locals {
  options = [
    "${var.enable_echo ? "echo" : ""}",
    "${var.enable_path_mtu_discovery ? "mtu" : ""}",
//    "${var.enable_ipv6_echo ? "v6echo" : ""}",
//    "${var.enable_ipv6_path_mtu_discovery ? "v6mtu" : ""}",
    "${var.vpc_only ? "vpc" : ""}",
  ]

  name_prefix = "${local.prefix}${var.name_prefix != "" ? "${var.name_prefix}_" : ""}icmp"
  name = "${local.prefix}${var.name_prefix != "" ? "${var.name_prefix}_" : ""}icmp-${join("-", local.options)}"
}

resource aws_security_group "instance" {
  vpc_id = "${var.vpc_id}"
  name_prefix = "${local.name_prefix}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_security_group_rule "ingress_echo_public" {
  count = "${(var.enable_echo && !var.vpc_only) ? 1 : 0}"

  security_group_id = "${aws_security_group.instance.id}"
  type = "ingress"

  protocol = "icmp"
  from_port = 8
  to_port = -1
  cidr_blocks = ["0.0.0.0/0"]
}

resource aws_security_group_rule "ingress_echo_vpc" {
  count = "${(var.enable_echo && var.vpc_only) ? 1 : 0}"

  security_group_id = "${aws_security_group.instance.id}"
  type = "ingress"

  protocol = "icmp"
  from_port = 8
  to_port = -1
  cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

resource aws_security_group_rule "ingress_path_mtu_discovery_public" {
  count = "${(var.enable_path_mtu_discovery && !var.vpc_only) ? 1 : 0}"

  security_group_id = "${aws_security_group.instance.id}"
  type = "ingress"

  protocol = "icmp"
  from_port = 3
  to_port = 4
  cidr_blocks = ["0.0.0.0/0"]
}

resource aws_security_group_rule "ingress_path_mtu_discovery_vpc" {
  count = "${(var.enable_path_mtu_discovery && var.vpc_only) ? 1 : 0}"

  security_group_id = "${aws_security_group.instance.id}"
  type = "ingress"

  protocol = "icmp"
  from_port = 3
  to_port = 4
  cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

// https://github.com/terraform-providers/terraform-provider-aws/issues/722
//resource aws_security_group_rule "ingress_ipv6_echo" {
//  count = "${var.enable_ipv6_echo ? 1 : 0}"
//
//  security_group_id = "${aws_security_group.instance.id}"
//  type = "ingress"
//
//  protocol = "icmpv6"
//  from_port = 128
//  to_port = 0
//  ipv6_cidr_blocks = ["::/0"]
//}
//
//resource aws_security_group_rule "ingress_ipv6_path_mtu_discovery" {
//  count = "${var.enable_ipv6_path_mtu_discovery ? 1 : 0}"
//
//  security_group_id = "${aws_security_group.instance.id}"
//  type = "ingress"
//
//  protocol = "icmpv6"
//  from_port = 2
//  to_port = 0
//  ipv6_cidr_blocks = ["::/0"]
//}
