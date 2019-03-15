
output "task-arn" {
  description = ""
  value = "${aws_ecs_task_definition.instance.arn}"
}
