/**
 *
 */

locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

locals {
  newbits = "${var.number_of_subnet <= 2 ? 1 : 2}"
}

data aws_availability_zones "reference" {}

resource aws_subnet "private" {
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

    Name = "${local.prefix}${var.vpc_name}-private-${count.index + 1}"
    SubnetType = "private"
  }
}

locals {
  nat_count = "${var.single_nat ? 1 : var.number_of_subnet}"
}

resource aws_eip "nat" {
  count = "${local.nat_count}"

  vpc = true

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "nat-${element(aws_subnet.private.*.tags.Name, count.index)}"
  }
}

resource aws_nat_gateway "instance" {
  count = "${local.nat_count}"

  allocation_id = "${element(aws_eip.nat.*.id, local.nat_count == 1 ? 0 : count.index)}"
  subnet_id = "${element(var.nat_subnet_ids, count.index)}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${element(aws_subnet.private.*.tags.Name, count.index)}"
  }
}

resource aws_egress_only_internet_gateway "instance" {
  vpc_id = "${var.vpc_id}"
}

resource aws_route_table "private" {
  count = "${var.number_of_subnet}"

  vpc_id = "${var.vpc_id}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.vpc_name}-private-${count.index + 1}"
    SubnetType = "private"
  }
}

resource aws_route "ipv4" {
  count = "${var.number_of_subnet}"

  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${element(aws_nat_gateway.instance.*.id, (local.nat_count == 1 ? 0 : count.index))}"
}

resource aws_route "ipv6" {
  count = "${var.number_of_subnet}"

  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id = "${aws_egress_only_internet_gateway.instance.id}"
}

resource aws_route_table_association "private" {
  count = "${var.number_of_subnet}"

  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
}
