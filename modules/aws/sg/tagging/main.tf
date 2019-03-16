
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

locals {
  name = "${local.prefix}${var.name_prefix != "" ? "${var.name_prefix}_" : ""}tagging"
}

resource aws_security_group "instance" {
  vpc_id = "${var.vpc_id}"
  name_prefix = "${local.name}-"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
