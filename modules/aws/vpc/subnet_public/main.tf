/**
 *
 */

data aws_availability_zones "reference" {}

locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

locals {
  newbits = "${var.number_of_subnet <= 2 ? 1 : 2}"
}

resource aws_subnet "public" {
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

    Name = "${local.prefix}public-${count.index + 1}"
    SubnetType = "public"
  }
}

resource aws_route_table "public" {
  vpc_id = "${var.vpc_id}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}public"
    SubnetType = "public"
  }
}

resource aws_route "ipv4" {
  route_table_id = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${var.internet_gateway_id}"
}

resource aws_route "ipv6" {
  route_table_id = "${aws_route_table.public.id}"
  destination_ipv6_cidr_block = "::/0"
  gateway_id = "${var.internet_gateway_id}"
}

resource aws_route_table_association "public" {
  count = "${var.number_of_subnet}"

  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
}
