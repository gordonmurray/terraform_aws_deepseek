variable "region" {
  type        = string
  description = "The AWS region to deploy to"
  default     = "eu-west-1"
}

variable "default_tag" {
  type        = string
  description = "A default tag to add to everything"
  default     = "terraform_aws_deepseek"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
