
output "user-arn" {
  description = ""
  value = "${aws_iam_user.instance.arn}"
}

output "user-password" {
  description = ""
  value = "${aws_iam_user_login_profile.instance.encrypted_password}"
}
