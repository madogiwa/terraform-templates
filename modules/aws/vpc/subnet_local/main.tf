/**
 *
 */

locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

data aws_availability_zones "reference" {}

locals {
  newbits = "${var.number_of_subnet <= 2 ? 1 : 2}"
}

resource aws_subnet "local" {
  count = "${var.number_of_subnet}"

  vpc_id = "${var.vpc_id}"
  availability_zone = "${data.aws_availability_zones.reference.names[count.index]}"
  cidr_block = "${cidrsubnet(var.cidr_block, local.newbits, count.index)}"
  ipv6_cidr_block = "${cidrsubnet(var.ipv6_cidr_block, local.newbits, count.index)}"

  map_public_ip_on_launch = false
  assign_ipv6_address_on_creation = false

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}local-${count.index + 1}"
    SubnetType = "local"
  }
}

resource aws_route_table "local" {
  vpc_id = "${var.vpc_id}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}local"
    SubnetType = "local"
  }
}

resource aws_route_table_association "local" {
  count = "${var.number_of_subnet}"

  route_table_id = "${aws_route_table.local.id}"
  subnet_id = "${element(aws_subnet.local.*.id, count.index)}"
}
