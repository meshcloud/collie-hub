variable "whitelisted_global_services" {
  type        = list(string)
  description = "List of AWS services that need global region access to work as intended"
  default = [
    "cloudfront",
    "iam",
    "route53",
    "support",
  ]
}

variable "whitelisted_regions" {
  type        = list(string)
  description = "List of AWS regions to allow"
  default = [
    "eu-central-1",
    "eu-west-1"
  ]
}