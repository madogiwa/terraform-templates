
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

resource aws_ecs_service "instance" {
  cluster = "${var.cluster_id}"
  name = "${local.prefix}${var.name}"
  task_definition = "${var.task_definition_arn}"

  launch_type = "${var.launch_type}"
  desired_count = "${var.desired_count}"

  network_configuration {
    subnets = ["${var.subnets}"]
    security_groups = ["${var.security_groups}"]
  }

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.name}"
  }
}
