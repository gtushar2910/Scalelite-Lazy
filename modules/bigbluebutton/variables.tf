variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "aws_ami" {
  description = "EC2 instance AMI"
  type        = string
}

variable "security_group_name" {
  description = "Name for security group"
  type        = string
}

variable "domain_name" {
  description = "Server domain name"
  type        = string
}

variable "subdomain_name" {
  description = "Server subdomain name"
  type        = string
}

variable "key_name" {
  description = "Name for your SSH public key"
  type        = string
}

variable "volume_size" {
  description = "Volume size in GiB"
  type        = number
}

variable "email" {
  description = "Email"
}

variable "region" {
  description = "region"
}

variable "spot_price"{
  description = "Spot Price"
}

variable "bbb_nic"{
  description = "bbb nic"
}

variable "gw"{
  description = "Gateway"
}

variable "private_ip_instance"{
  description = "private_ip_instance"
}

variable "availability_zone" {
  description = "availability_zone"
}