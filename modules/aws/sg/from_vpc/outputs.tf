
output "sg-arn" {
  description = "ARN of security group"
  value = "${aws_security_group.instance.arn}"
}
