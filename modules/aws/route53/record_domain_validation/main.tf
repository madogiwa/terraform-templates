
resource aws_route53_record "validation" {
  zone_id = "${var.zone_id}"
  name = "${var.record_name}"
  type = "${var.record_type}"
  records = ["${var.record_value}"]
  ttl = 300
}
