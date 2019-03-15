
output "alb-arn" {
  description = "ARN of alb"
  value = "${aws_lb.instance.arn}"
}

output "alb-dns_name" {
  description = "dns name"
  value = "${aws_lb.instance.dns_name}"
}

output "https-arn" {
  description = "ARN of https listener"
  value = "${aws_alb_listener.https.arn}"
}
