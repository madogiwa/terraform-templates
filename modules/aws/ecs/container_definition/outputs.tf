
output "json" {
  value = <<EOF
{
  "name": "${var.name}",
  "image": "${var.image}",
  ${var.credentials_parameter == "" ? "" : "\"repositoryCredentials\":{ \"CredentialsParameter\": \"${var.credentials_parameter}\" },"}
  ${var.cpu == 0 ? "" : "\"cpu\": ${var.cpu},"}
  ${var.memory == 0 ? "" : "\"memory\": ${var.memory},"}
  ${var.memory_reservation == 0 ? "" : "\"memoryReservation\": ${var.memory_reservation},"}
  "links": ${jsonencode(var.links)},
  "portMappings": ${replace(jsonencode(var.port_mappings), "/\"(\\d+)\"/", "$1")},
  "essential": ${var.essential ? true : false},
  "entryPoint": ${jsonencode(var.entry_point)},
  "command": ${jsonencode(var.command)},
  "environment": ${jsonencode(var.environment)},
  "mountPoints": ${jsonencode(var.mount_points)},
  "volumesFrom": ${jsonencode(var.volumes_from)},
  "linuxParameters": ${var.linux_parameters},
  "secrets": ${jsonencode(var.secrets)},
  ${var.hostname == "" ? "" : "\"hostname\": \"${var.hostname}\","}
  ${var.user == "" ? "" : "\"user\": \"${var.user}\","}
  ${var.working_directory == "" ? "" : "\"workingDirectory\": \"${var.working_directory}\","}
  "disableNetworking": ${var.disable_networking ? true : false},
  "privileged": ${var.privileged ? true : false},
  "readonlyRootFilesystem": ${var.readonly_root_filesystem ? true : false},
  "dnsServers": ${jsonencode(var.system_controls)},
  "dnsSearchDomains": ${jsonencode(var.dns_search_domains)},
  "extraHosts": ${jsonencode(var.extra_hosts)},
  "dockerSecurityOptions": ${jsonencode(var.docker_security_options)},
  "interactive": ${var.interactive ? true : false},
  "pseudoTerminal": ${var.pseudo_terminal ? true : false},
  "dockerLabels": ${jsonencode(var.docker_labels)},
  "ulimits": ${replace(jsonencode(var.ulimits), "/\"(\\d+)\"/", "$1")},
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      ${var.log_datetime_format == "" ? "" : "\"awslogs-datetime-format\": \"${var.log_datetime_format}\","}
      ${var.log_multiline_pattern == "" ? "" : "\"awslogs-multiline-pattern\": \"${var.log_multiline_pattern}\","}
      ${var.log_stream_prefix == "" ? "" : "\"awslogs-stream-prefix\": \"${var.log_stream_prefix}\","}
      "awslogs-region": "${local.region}",
      "awslogs-group": "${var.log_group}"
    }
  },
  ${length(keys(var.health_check)) == 0 ? "" : "\"healthCheck\": ${replace(jsonencode(var.port_mappings), "/\"(\\d+)\"/", "$1")},"}
  "systemControls": ${jsonencode(var.system_controls)},
  "resourceRequirements": ${jsonencode(var.resource_requirements)}
}
EOF
}
