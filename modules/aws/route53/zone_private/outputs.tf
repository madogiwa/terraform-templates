
output "zone-zone_id" {
  value = "${aws_route53_zone.instance.zone_id}"
}

output "zone-name" {
  value = "${aws_route53_zone.instance.name}"
}
