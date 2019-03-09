
variable "aws_region" {
  description = "ex) ap-northeast-1"
}

variable "vpc_cidr_block" {
  description = "ex) 10.0.0.0/17"
}

variable "route53_private_fqdn" {
  description = "ex) aws.internal."
}

variable "servicediscovery_private_fqdn" {
  description = "ex) aws-sd.internal."
}

variable "route53_public_fqdn" {
  description = "ex) aws.example.com"
}

variable "servicediscovery_public_fqdn" {
  description = "ex) aws-sd.example.com"
}
