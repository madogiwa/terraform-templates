
output "subnet-ids" {
  description = "IDs of subnets"
  value = ["${aws_subnet.private.*.id}"]
}

output "rt-ids" {
  description = "ID of RouteTable"
  value = ["${aws_route_table.private.*.id}"]
}
