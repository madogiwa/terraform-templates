
module "vpc" {
  source = "../../../modules/aws/vpc/public_private"
  cidr_block = "${var.vpc_cidr_block}"
  single_nat = true
  number_of_subnet = 2
}

module "vpc_endpoint_s3" {
  source = "../../../modules/aws/vpc_endpoint/s3"

  vpc_id = "${module.vpc.vpc-id}"
  route_table_ids = "${module.vpc.route_private-ids}"
}

module "vpc_endpoint_dynamodb" {
  source = "../../../modules/aws/vpc_endpoint/dynamodb"

  vpc_id = "${module.vpc.vpc-id}"
  route_table_ids = "${module.vpc.route_private-ids}"
}

module "vpc_endpoint_ecs" {
  source = "../../../modules/aws/vpc_endpoint/ecs"

  vpc_id = "${module.vpc.vpc-id}"
  subnet_ids = "${module.vpc.subnet_private-ids}"
}

module "vpc_endpoint_ecr" {
  source = "../../../modules/aws/vpc_endpoint/ecr"

  vpc_id = "${module.vpc.vpc-id}"
  subnet_ids = "${module.vpc.subnet_private-ids}"
}

module "vpc_endpoint_kinesis" {
  source = "../../../modules/aws/vpc_endpoint/kinesis"

  vpc_id = "${module.vpc.vpc-id}"
  subnet_ids = "${module.vpc.subnet_private-ids}"
}

module "route53_private_zone" {
  source = "../../../modules/aws/route53/zone_private"
  fqdn = "${var.route53_private_fqdn}"
  vpc_id = "${module.vpc.vpc-id}"
}

module "route53_public_zone" {
  source = "../../../modules/aws/route53/zone_public"
  fqdn = "${var.route53_public_fqdn}"
}

module "route53_servicediscovery_private" {
  source = "../../../modules/aws/service_discovery/private"
  zone_name = "${var.servicediscovery_private_fqdn}"
  vpc_id = "${module.vpc.vpc-id}"
}

module "route53_servicediscovery_public" {
  source = "../../../modules/aws/service_discovery/public"
  zone_name = "${var.servicediscovery_public_fqdn}"
}
