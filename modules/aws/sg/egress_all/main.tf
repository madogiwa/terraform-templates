
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

locals {
  name = "${local.prefix}${var.name_prefix != "" ? "${var.name_prefix}-" : ""}egress_all"
}

resource aws_security_group "instance" {
  vpc_id = "${var.vpc_id}"
  name_prefix = "${local.name}-"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_security_group_rule "egress" {
  security_group_id = "${aws_security_group.instance.id}"
  type = "egress"

  protocol = "-1"
  from_port = 0
  to_port = 0
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}
