
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable "name" {
  description = "Log group name"
}

variable "retention_in_days" {
  description = "Delete logs after specify days"
  default = 30
}
