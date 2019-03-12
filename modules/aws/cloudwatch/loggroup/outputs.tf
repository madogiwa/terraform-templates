
output "loggroup-name" {
  description = "Log group name"
  value = "${aws_cloudwatch_log_group.instance.name}"
}
