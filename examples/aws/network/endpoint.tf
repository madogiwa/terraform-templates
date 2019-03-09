
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
