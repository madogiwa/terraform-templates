
output "vpc-id" {
  description = "ID of VPC"
  value = "${aws_vpc.main.id}"
}

output "subnet_all-ids" {
  description = "IDs of all subnets"
  value = ["${module.subnet_public.subnet-ids}"]
}

output "subnet_public-ids" {
  description = "IDs of public subnets"
  value = ["${module.subnet_public.subnet-ids}"]
}

output "route_all-ids" {
  description = "IDs of all route tables"
  value = ["${module.subnet_public.rt-id}"]
}

output "route_public-id" {
  description = "ID of route table for public subnet"
  value = "${module.subnet_public.rt-id}"
}
