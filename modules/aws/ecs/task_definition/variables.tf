
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable "family" {
  default = "Task definition name"
}

variable "container_definitions" {
  description = ""
  type = "list"
}

variable "compatibility" {
  description = "FARGATE or EC2"
  default = "FARGATE"
}

variable "cpu" {
  description = "Number of cpu units. 1024 == 1core"
  default = 256
}

variable "memory" {
  description = "amount of memory used by task"
  default = 512
}
