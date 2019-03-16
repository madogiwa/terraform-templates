
output "sg-id" {
  description = "ID of security group"
  value = "${aws_security_group.instance.id}"
}
