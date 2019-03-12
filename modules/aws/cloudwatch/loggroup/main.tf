
locals {
  suffix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "-${terraform.workspace}" : ""}"
}

resource aws_cloudwatch_log_group "instance" {
  name = "${var.name}${local.suffix}"
  retention_in_days = "${var.retention_in_days}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${var.name}${local.suffix}"
  }
}
