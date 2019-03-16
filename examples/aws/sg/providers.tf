
provider "archive" {
  version = "~> 1.1"
}

provider "null" {
  version = "~> 2.1"
}

provider "random" {
  version = "~> 2.0"
}

provider "template" {
  version = "~> 2.1"
}

provider aws {
  region = "${var.aws_region}"
  version = "~> 2.0"
}
