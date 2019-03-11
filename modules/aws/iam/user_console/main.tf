
data aws_caller_identity "self" {}

resource aws_iam_user "instance" {
  name = "${var.name}"
  path = "${var.path}"
  force_destroy = true

  tags = {
    managed-by = "Terraform"
    terraform-workspace = "${terraform.workspace}"

    Name = "${var.name}"
  }
}

resource aws_iam_user_login_profile "instance" {
  user = "${aws_iam_user.instance.name}"
  pgp_key = "${var.pgp_key}"
}

data aws_iam_policy_document "mfa" {
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:DeleteVirtualMFADevice"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.self.account_id}:mfa/${var.name}",
      "arn:aws:iam::${data.aws_caller_identity.self.account_id}:user/${var.name}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:DeactivateMFADevice"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.self.account_id}:mfa/${var.name}",
      "arn:aws:iam::${data.aws_caller_identity.self.account_id}:user/${var.name}"
    ]
    condition {
      test = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values = [true]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ListUsers"
    ]
    resources = ["*"]
  }
}

resource aws_iam_policy "mfa" {
  policy = "${data.aws_iam_policy_document.mfa.json}"
}

resource aws_iam_user_policy_attachment "mfa" {
  user = "${aws_iam_user.instance.name}"
  policy_arn = "${aws_iam_policy.mfa.arn}"
}
