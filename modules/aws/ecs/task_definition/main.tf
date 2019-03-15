
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

resource "aws_iam_role" "ecs_task_execution" {
  name_prefix = "${local.prefix}${var.family}-ecsTaskExecutionRole"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_task.json}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.family}-ecsTaskExecutionRole"
  }
}

data "aws_iam_policy_document" "ecs_task" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task" {
  role = "${aws_iam_role.ecs_task_execution.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource aws_ecs_task_definition "instance" {
  family = "${local.prefix}${var.family}"
  container_definitions = "[${join(",", var.container_definitions)}]"

  requires_compatibilities = ["${var.compatibility}"]
  cpu = "${var.cpu}"
  memory = "${var.memory}"

  task_role_arn = ""
  execution_role_arn = "${aws_iam_role.ecs_task_execution.arn}"
  network_mode = "awsvpc"

//ipc_mode = ""
//pid_mode = ""
//volume {
//  name = ""
//}
//placement_constraints {
//  type = ""
//}

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.family}"
  }
}
