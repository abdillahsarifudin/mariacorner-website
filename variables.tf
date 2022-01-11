variable "mariascorner-s3-bucket-name" {
  type    = string
  default = "mariascorner.co"
}

variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}

variable "mariascorner-domain-name" {
  type    = string
  default = "mariascorner.co"
}