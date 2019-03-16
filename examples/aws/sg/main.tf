
data aws_vpc "main" {
  default = true
}

module "sg_egress_all" {
  source = "../../../modules/aws/sg/egress_all"

  vpc_id = "${data.aws_vpc.main.id}"
  name_prefix = "main"
}

module "sg_egress_vpc" {
  source = "../../../modules/aws/sg/egress_vpc"

  vpc_id = "${data.aws_vpc.main.id}"
  name_prefix = "main"
}

module "sg_from_all-web" {
  source = "../../../modules/aws/sg/from_all"

  vpc_id = "${data.aws_vpc.main.id}"
  name_prefix = "web"
  ports = [80,443,8080]
}

module "sg_from_vpc-web" {
  source = "../../../modules/aws/sg/from_vpc"

  vpc_id = "${data.aws_vpc.main.id}"
  ports = [80,443]
}

module "sg_from_ip-web" {
  source = "../../../modules/aws/sg/from_ip"

  vpc_id = "${data.aws_vpc.main.id}"
  ports = [80,443]
  cidr_blocks = ["1.1.1.1/32", "8.8.8.8/32"]
}

module "sg_tagging-sg1" {
  source = "../../../modules/aws/sg/tagging"

  vpc_id = "${data.aws_vpc.main.id}"
}

module "sg_from_sg-web" {
  source = "../../../modules/aws/sg/from_sg"

  vpc_id = "${data.aws_vpc.main.id}"
  ports = [80,443]
  sg_id = "${module.sg_tagging-sg1.sg-id}"
}

module "sg_icmp-public" {
  source = "../../../modules/aws/sg/icmp"

  vpc_id = "${data.aws_vpc.main.id}"
  enable_path_mtu_discovery = true
//  enable_ipv6_path_mtu_discovery = true
}

module "sg_icmp-vpc" {
  source = "../../../modules/aws/sg/icmp"

  vpc_id = "${data.aws_vpc.main.id}"
  vpc_only = true
}
