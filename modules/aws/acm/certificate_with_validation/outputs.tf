
output "certificate-arn" {
  description = "ARN of Certificate"
  value = "${aws_acm_certificate.instance.arn}"
}
