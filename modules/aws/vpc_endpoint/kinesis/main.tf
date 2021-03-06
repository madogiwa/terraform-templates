
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

data aws_region "current" {}

locals {
  region = "${var.region != "" ? var.region : data.aws_region.current.name}"
}

resource random_id sg {
  byte_length = 8
}

resource aws_security_group "tag" {
  vpc_id = "${var.vpc_id}"
  name_prefix = "${local.prefix}endpoint_kinesis-"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}endpoint_kinesis"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_security_group "allow" {
  count = "${var.allow_from_all ? 1 : 0}"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_vpc_endpoint "streams" {
  vpc_id = "${var.vpc_id}"
  private_dns_enabled = "${var.private_dns_enabled}"
  service_name = "com.amazonaws.${local.region}.kinesis-streams"
  vpc_endpoint_type = "Interface"

  subnet_ids = ["${var.subnet_ids}"]
  security_group_ids = ["${aws_security_group.tag.id}", "${aws_security_group.allow.*.id}"]
}
