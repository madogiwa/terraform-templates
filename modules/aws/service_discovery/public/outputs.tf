
output "namespace-id" {
  value = "${aws_service_discovery_public_dns_namespace.instance.id}"
}

output "namespace-name" {
  value = "${aws_service_discovery_public_dns_namespace.instance.name}"
}

data aws_route53_zone "reference" {
  zone_id = "${aws_service_discovery_public_dns_namespace.instance.hosted_zone}"
  private_zone = false
}

output "zone-name_servers" {
  value = ["${data.aws_route53_zone.reference.name_servers}"]
}
