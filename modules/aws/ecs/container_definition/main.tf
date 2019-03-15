
data aws_region "current" {}

locals {
  region = "${var.log_region != "" ? var.log_region : data.aws_region.current.name}"
}
