
output "subnet-ids" {
  description = "IDs of subnets"
  value = ["${aws_subnet.public.*.id}"]
}

output "rt-id" {
  description = "ID of RouteTable"
  value = "${aws_route_table.public.id}"
}
