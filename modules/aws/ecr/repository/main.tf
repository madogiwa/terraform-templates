
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

resource aws_ecr_repository "instance" {
  name = "${local.prefix}${var.name}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.name}"
  }
}

resource aws_ecr_lifecycle_policy "instance" {
  repository = "${aws_ecr_repository.instance.name}"
  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 10,
      "description": "Expire untagged images older than ${var.expire_untagged_days} days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": ${var.expire_untagged_days}
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 20,
      "description": "Keep last ${var.expire_tagged_generation} tagged images prefixed with '${var.tag_prefix}'",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["${var.tag_prefix}"],
        "countType": "imageCountMoreThan",
        "countNumber": ${var.expire_tagged_generation}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
