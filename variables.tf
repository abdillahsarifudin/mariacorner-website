variable "s3-bucket-name" {
  type    = string
  default = "mcnasilemak.com"
}

variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}