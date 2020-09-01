variable "aws_profile" {
  description = "The AWS profile to use"
  default     = "default"
}

variable "aws_region" {
  description = "The AWS region to provision resources in"
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name for your SSH public key"
  default     = "bigbluebutton"
}

variable "bigbluebutton_security_group_name" {
  description = "Name for bigbluebutton security group"
  default     = "bigbluebutton-security-group"
}

variable "scalelite_security_group_name" {
  description = "Name for scalelite security group"
  default     = "scalelite-security-group"
}

variable "private_ip_instances"{
  description = "Privat IP Addresses"
  type = list(string)
}

variable "subnet_prefix"{
  description = "subnet_prefix"
}

variable "availability_zone"{
  description = "availability_zone"
}