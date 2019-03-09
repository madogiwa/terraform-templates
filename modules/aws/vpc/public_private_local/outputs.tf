
output "vpc-id" {
  description = "ID of VPC"
  value = "${aws_vpc.main.id}"
}

output "subnet_all-ids" {
  description = "IDs of all subnets"
  value = ["${module.subnet_public.subnet-ids}", "${module.subnet_private.subnet-ids}", "${module.subnet_local.subnet-ids}"]
}

output "subnet_public-ids" {
  description = "IDs of public subnets"
  value = ["${module.subnet_public.subnet-ids}"]
}

output "subnet_private-ids" {
  description = "IDs of private subnets"
  value = ["${module.subnet_private.subnet-ids}"]
}

output "subnet_local-ids" {
  description = "IDs of local subnets"
  value = ["${module.subnet_local.subnet-ids}"]
}
