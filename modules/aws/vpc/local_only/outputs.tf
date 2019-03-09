
output "vpc-id" {
  description = "ID of VPC"
  value = "${aws_vpc.main.id}"
}

output "subnet_all-ids" {
  description = "IDs of all subnets"
  value = ["${module.subnet_local.subnet-ids}"]
}

output "subnet_local-ids" {
  description = "IDs of local subnets"
  value = ["${module.subnet_local.subnet-ids}"]
}

output "route_all-ids" {
  description = "IDs of all route tables"
  value = ["${module.subnet_local.rt-id}"]
}

 output "route_localids" {
  description = "ID of route table for private subnet"
  value = "${module.subnet_local.rt-id}"
}
