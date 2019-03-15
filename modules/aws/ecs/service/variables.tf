
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable "cluster_id" {
  description = "Cluster ID"
}

variable "name" {
  description = "Service name"
}

variable "task_definition_arn" {
  description = "ARN of task definition"
}

variable "launch_type" {
  description = "EC2 or FARGATE"
  default = "FARGATE"
}

variable "desired_count" {
  description = "Desired task count"
  default = 1
}

variable "ignore_change_desired_count" {
  description = "Ignore changes to desired count"
  default = false
}

variable "subnets" {
  description = ""
  type = "list"
}

variable "security_groups" {
  description = ""
  type = "list"
}

variable "assign_public_ip" {
  description = ""
  default = false
}

variable "service_discovery_arn" {
  description = "Register specify Service discovery"
  default = ""
}
