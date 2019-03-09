
output "subnet-ids" {
  description = "IDs of subnets"
  value = ["${aws_subnet.local.*.id}"]
}

output "rt-id" {
  description = "ID of RouteTable"
  value = "${aws_route_table.local.id}"
}
