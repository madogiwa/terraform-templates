
output "json" {
  value = <<EOF
{
  "capabilities": {
    "add": ${jsonencode(var.capabilities_add)},
    "drop": ${jsonencode(var.capabilities_drop)}
  },
  "devices": ${jsonencode(var.devices)},
  "initProcessEnabled": ${var.init_process_enabled ? true : false},
  ${var.shared_memory_size == -1 ? "" : "\"sharedMemorySize\": ${var.shared_memory_size},"}
  "tmpfs": ${jsonencode(var.tmpfs)}
}
EOF
}
