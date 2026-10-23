variable "aws_region" {
  type    = string
  default = "ap-south-2"
}

variable "ami_id" {
  description = "Region-specific Linux AMI"
  type        = string
  default     = "ami-04f617474d20eae29"
}

variable "subnet_id" {
  description = "Existing subnet ID"
  type        = string
  default     = "subnet-0bc7540853404c75d"
}
