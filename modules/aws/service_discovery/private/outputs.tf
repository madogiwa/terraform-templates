
output "namespace-id" {
  value = "${aws_service_discovery_private_dns_namespace.instance.id}"
}

output "zone-name" {
  value = "${aws_service_discovery_private_dns_namespace.instance.name}"
}
