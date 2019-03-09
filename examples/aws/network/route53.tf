
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
