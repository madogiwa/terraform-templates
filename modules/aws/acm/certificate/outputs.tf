
output "certificate-arn" {
  description = "ARN of Certificate"
  value = "${aws_acm_certificate.instance.arn}"
}

output "domain_validation-name" {
  description = "record name for domain validation"
  value = "${lookup(aws_acm_certificate.instance.domain_validation_options[0], "resource_record_name")}"
}

output "domain_validation-type" {
  description = "record type for domain validation"
  value = "${lookup(aws_acm_certificate.instance.domain_validation_options[0], "resource_record_type")}"
}

output "domain_validation-value" {
  description = "record value for domain validation"
  value = "${lookup(aws_acm_certificate.instance.domain_validation_options[0], "resource_record_value")}"
}
