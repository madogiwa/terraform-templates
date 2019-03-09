
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

data aws_region "current" {}

locals {
  region = "${var.region != "" ? var.region : data.aws_region.current.name}"
}

resource aws_security_group "tag" {
  vpc_id = "${var.vpc_id}"
  name_prefix = "${local.prefix}endpoint_ecr"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}endpoint_ecr"
  }
}

resource aws_security_group "allow" {
  count = "${var.allow_from_all == true ? 1 : 0}"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol = "-1"
    from_port = 0
    to_port = 65535
    cidr_blocks = ["0.0.0.0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"
  }
}

resource aws_vpc_endpoint "agent" {
  vpc_id = "${var.vpc_id}"
  private_dns_enabled = "${var.private_dns_enabled}"
  service_name = "com.amazonaws.${local.region}.ecs-agent"
  vpc_endpoint_type = "Interface"

  subnet_ids = ["${var.subnet_ids}"]
  security_group_ids = ["${aws_security_group.tag.id}"]
}

resource aws_vpc_endpoint "telemetry" {
  vpc_id = "${var.vpc_id}"
  private_dns_enabled = "${var.private_dns_enabled}"
  service_name = "com.amazonaws.${local.region}.ecs-telemetry"
  vpc_endpoint_type = "Interface"

  subnet_ids = ["${var.subnet_ids}"]
  security_group_ids = ["${aws_security_group.tag.id}"]

  depends_on = ["aws_vpc_endpoint.agent"]
}

resource aws_vpc_endpoint "ecs" {
  vpc_id = "${var.vpc_id}"
  private_dns_enabled = true
  service_name = "com.amazonaws.${local.region}.ecs"
  vpc_endpoint_type = "Interface"

  subnet_ids = ["${var.subnet_ids}"]
  security_group_ids = ["${aws_security_group.tag.id}"]

  depends_on = ["aws_vpc_endpoint.telemetry"]
}
