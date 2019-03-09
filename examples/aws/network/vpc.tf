
module "vpc" {
  source = "../../../modules/aws/vpc/public_private"

  cidr_block = "${var.vpc_cidr_block}"
}
