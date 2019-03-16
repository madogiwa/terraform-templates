
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

locals {
  name_prefix = "${local.prefix}${var.name_prefix != "" ? "${var.name_prefix}_" : ""}from_vpc-"
  name = "${local.prefix}${var.name_prefix != "" ? "${var.name_prefix}_" : ""}${join("-", var.ports)}_from_vpc"
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

resource aws_security_group_rule "ingress" {
  count = "${length(var.ports)}"

  security_group_id = "${aws_security_group.instance.id}"
  type = "ingress"

  protocol = "${var.protocol}"
  from_port = "${element(var.ports, count.index)}"
  to_port = "${element(var.ports, count.index)}"

  cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}
