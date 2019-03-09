/**
 *
 */

locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

resource aws_vpc "main" {
  cidr_block = "${var.cidr_block}"
  assign_generated_ipv6_cidr_block = true

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.name}"
  }
}

resource aws_internet_gateway "instance" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${aws_vpc.main.tags.Name}"
  }
}

locals {
  newbits = "${var.number_of_subnet <= 2 ? 1 : 2}"
}

module "subnet_public" {
  source = "../subnet_public"

  vpc_id = "${aws_vpc.main.id}"
  vpc_name = "${aws_vpc.main.tags.Name}"
  number_of_subnet = "${var.number_of_subnet}"
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, 2, 0)}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, (8 - local.newbits), 0)}"
  internet_gateway_id = "${aws_internet_gateway.instance.id}"
  enable_auto_workspace_prefix = false
}

module "subnet_local" {
  source = "../subnet_local"

  vpc_id = "${aws_vpc.main.id}"
  vpc_name = "${aws_vpc.main.tags.Name}"
  number_of_subnet = "${var.number_of_subnet}"
  cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, 2, 2)}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, (8 - local.newbits), 2)}"
  enable_auto_workspace_prefix = false
}
