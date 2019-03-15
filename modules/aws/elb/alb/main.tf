
locals {
  prefix = "${(var.enable_auto_workspace_prefix && terraform.workspace != "default") ? "${terraform.workspace}-" : ""}"
}

resource aws_security_group "tag" {
  vpc_id = "${var.vpc_id}"
  name_prefix = "${local.prefix}alb-"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}endpoint_ecs"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_security_group "allow" {
  count = "${var.allow_from_all ? 1 : 0}"
  vpc_id = "${var.vpc_id}"

  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource random_id "len8" {
  byte_length = 6
}

resource aws_lb "instance" {
  load_balancer_type = "application"
  internal = "${var.is_internal}"
  name = "${local.prefix}${var.name}-${random_id.len8.hex}"
  ip_address_type = "dualstack"

  subnets = ["${var.subnet_ids}"]
  security_groups = ["${aws_security_group.tag.id}", "${aws_security_group.allow.*.id}"]

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.name}-${random_id.len8.hex}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource aws_alb_listener "http_redirect" {
  count = "${var.enable_http_redirection ? 1 : 0}"

  load_balancer_arn = "${aws_lb.instance.arn}"
  protocol = "HTTP"
  port = 80

  default_action {
    type = "redirect"

    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource aws_alb_listener "https" {
  load_balancer_arn = "${aws_lb.instance.arn}"
  protocol = "HTTPS"
  port = 443

  certificate_arn = "${var.certificate_arn}"

  default_action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.default.arn}"
  }
}

resource aws_alb_target_group "default" {
  name = "${local.prefix}${var.name}-default-${random_id.len8.hex}"

  target_type = "ip"
  protocol = "HTTP"
  port = 80
  vpc_id = "${var.vpc_id}"

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${local.prefix}${var.name}-default-${random_id.len8.hex}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
