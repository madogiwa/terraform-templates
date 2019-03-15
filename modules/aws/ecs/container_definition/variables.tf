
variable "name" {
  description = ""
}

variable "image" {
  description = ""
}

variable "credentials_parameter" {
  description = ""
  default = ""
}

variable "cpu" {
  description = ""
  default = 0
}

variable "memory" {
  description = ""
  default = 0
}

variable "memory_reservation" {
  description = ""
  default = 0
}

variable "links" {
  description = ""
  type = "list"
  default = []
}

variable "port_mappings" {
  description = ""
  type = "list"
  default = []
}

variable "essential" {
  description = ""
  default = true
}

variable "entry_point" {
  description = ""
  type = "list"
  default = []
}

variable "command" {
  description = ""
  type = "list"
  default = []
}

variable "environment" {
  description = ""
  type = "list"
  default = []
}

variable "mount_points" {
  description = ""
  type = "list"
  default = []
}

variable "volumes_from" {
  description = ""
  type = "list"
  default = []
}

variable "linux_parameters" {
  description = ""
  default = "{}"
}

variable "secrets" {
  description = ""
  type = "list"
  default = []
}

variable "hostname" {
  description = ""
  default = ""
}

variable "user" {
  description = ""
  default = ""
}

variable "working_directory" {
  description = ""
  default = ""
}

variable "disable_networking" {
  description = ""
  default = false
}

variable "privileged" {
  description = ""
  default = false
}

variable "readonly_root_filesystem" {
  description = ""
  default = false
}

variable "dns_servers" {
  description = ""
  type = "list"
  default = []
}

variable "dns_search_domains" {
  description = ""
  type = "list"
  default = []
}

variable "extra_hosts" {
  description = ""
  type = "list"
  default = []
}

variable "docker_security_options" {
  description = ""
  type = "list"
  default = []
}

variable "interactive" {
  description = ""
  default = true
}

variable "pseudo_terminal" {
  description = ""
  default = true
}

variable "docker_labels" {
  description = ""
  type = "map"
  default = {}
}

variable "ulimits" {
  description = ""
  type = "list"
  default = []
}

variable "log_datetime_format" {
  description = ""
  default = ""
}

variable "log_multiline_pattern" {
  description = ""
  default = ""
}

variable "log_region" {
  description = ""
  default = ""
}

variable "log_group" {
  description = ""
  default = ""
}

variable "log_stream_prefix" {
  description = ""
}

variable "health_check" {
  description = ""
  type = "map"
  default = {}
}

variable "system_controls" {
  description = ""
  type = "list"
  default = []
}

variable "resource_requirements" {
  description = ""
  type = "list"
  default = []
}
