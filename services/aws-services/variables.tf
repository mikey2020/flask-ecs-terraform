variable "aws_region" {
  description = "AWS region"
  default = "us-east-2"
}

variable "aws_access_key" {
  description = "AWS access key"
  type = string
  sensitive = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type = string
  sensitive = true
}

