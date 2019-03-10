
variable "enable_auto_workspace_prefix" {
  description = "Enable to append prefix first of resource name"
  default = true
}

variable "name" {
  description = "Repository name"
}

variable "expire_untagged_days" {
  description = "Delete untagged images after specify days"
  default = 7
}

variable "expire_tagged_generation" {
  description = "Delete tagged images older than specify generation"
  default = 3
}

variable "tag_prefix" {
  description = "Option of 'expire_tagged_generation' only affect images begin with 'tag_prefix'"
  default = "v"
}
