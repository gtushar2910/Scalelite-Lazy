

variable "bigbluebutton_security_group_name" {
  description = "Name for bigbluebutton security group"
  default     = "bigbluebutton-security-group"
}

variable "scalelite_security_group_name" {
  description = "Name for scalelite security group"
  default     = "scalelite-security-group"
}

# variable "private_ip_instances"{
#   description = "Privat IP Addresses"
#   type = list(string)
# }

variable "subnet_prefix"{
  description = "subnet_prefix"
}

variable "availability_zone"{
  description = "availability_zone"
}