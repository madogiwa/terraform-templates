
variable "capabilities_add" {
  description = ""
  type = "list"
  default = []
}

variable "capabilities_drop" {
  description = ""
  type = "list"
  default = []
}

variable "devices" {
  description = ""
  type = "list"
  default = []
}

variable "init_process_enabled" {
  description = ""
  default = true
}

variable "shared_memory_size" {
  description = ""
  default = -1
}

variable "tmpfs" {
  description = ""
  type = "list"
  default = []
}
