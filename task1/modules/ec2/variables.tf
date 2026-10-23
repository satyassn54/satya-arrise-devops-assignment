variable "instances" {
  type = map(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
    key_name      = string
    environment   = string
    owner         = string
    protect       = optional(bool, false)
  }))

  validation {
    condition = anytrue([
      for instance in values(var.instances) :
      contains(["io1", "io2"], instance.volume_type)
    ])
    error_message = "please choose atleast 1 instance with io1 or io2 storage "
  }
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet id of EC2 instance"
  type        = string
}

