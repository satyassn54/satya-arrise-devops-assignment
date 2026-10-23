
variable "account_a_profile" {
  type    = string
  default = "account-a"
}

variable "account_a_id" {
  type    = string
  default = "000000000000"
}

variable "account_b_profile" {
  type    = string
  default = "account-b"
}

variable "account_b_id" {
  type    = string
  default = "111111111111"
}

variable "account_a_user1" {
  type = string
}

variable "account_a_user2" {
  type = string
}


variable "bucket_name" {
  description = "Globally unique bucket name in Account B"
  type        = string
  default     = "arrise-assignment-task3-account-b"
}

variable "console_pgp_key" {
  description = "Base64-encoded PGP public key for encrypting generated console passwords"
  type        = string
  sensitive   = true
  default     = "mQGNBGrV5nYBDADxkWgmQ51a/h7qAazlrtZJNuMPCPfCzxNiFpB781I6X6ueYpGAc9wZPDD1HIgViHCkXQ9v0/nXT5njm4uBCCwfpIrTnRq+atFk3zHymV+NUWniMr/Cq3U/AMWmloeLJLRhqhdMfIAjSjWtKDiNQS+HSjRQMxIXivLSOYRiYehdMUXpoirFqungPtZEMMbrV8zA3Lq11ApaU8SY6Zx02i/WMgzzgeyg+EJa9Ay3EZJ/aZx0CToTPAOOAW+YKPlS4wbE5sMRN7j3dF2Jiq+IVvypB2HbRJEqfjILaKhT5RL/gQaQCSCRUzcflPauXC3YSCpkDPUk9wP5YoNkIIaCbGb0E4IJuTfmSwKG+3lml9AnVRNqCcm6X6Fv59BB8jRFJ45ts6kOcBuqfCPo2V66+YGpyfBA5wT1U7hZffNUcUBJNs+rmy0NjtXVbXMP6/PjI8VnCxii4cnhoNxxF/j2Ua5/0F6MZbbWWpWK9y2D0zFxVj7InLuNsge3x3p27PcFHeMAEQEAAbQRVGVycmFmb3JtIElBTSBMYWKJAdQEEwEKAD4WIQSYoBvUKg9Cd9YglXZoDRYZyrF6kgUCatXmdgIbDQUJAeEzgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBoDRYZyrF6kiTDC/9wZpMM7sYktqfqkFR2CxLIGa43KzLmTYOa0GmxPMHbF6sab+6wflB93KHlum9IkEs0lZ0G7c00OIbiJan9BbrNlH88rV1j6DAkCusG3Bdp7OxvDbkRgfAMoR9Bo/qLTsjmMu56qtLEsDA7sqtw5rctpCxOFNdcWh1qJ2wHwLmjY4nWQBLmlYwKilnnexCiKYnMs62G/WfeXWFjPNNQGXnUUtfb1ofR1ZBTKmKUuIUe1wFsvtX9Sb3IU3zwgn0FjGFfCOAwDWaBFccrKIn17DUVxU9QM6+VjVpMjcT8zghGZmEsAXnsAg39Wm9ybnzYg6qx1xaS/6Nz1YICCLepZhx6RsMBCDFLKlYb6NJbKQ782zY+1npNmqaaOf2ob9kp2yxGYzSV4Xj2dz8S7KWGqcw1dlAxOSDjJQGtwPTmKckuKZKeCTDDO43gtvtrP/djn/+UPrZrBPiJQ1F0tQlCJd+A2vuRLg7iSkDvzwzvIUwC5YZaxRNFSaDxxG2idrh0OLQ="
}
