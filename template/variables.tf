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
  default     = "Wordpress-aws1"
}

variable "bigbluebutton_instance_type" {
  description = "EC2 instance type (bigbluebutton)"
  default     = "t3.xlarge"
}

variable "bigbluebutton_aws_ami" {
  description = "EC2 instalnce AMI (bigbluebutton)"
  default     = "ami-039a49e70ea773ffc"
}

variable "bigbluebutton_domain_name" {
  description = "Server domain name (bigbluebutton)"
  default     = "example.com"
}

variable "bigbluebutton_subdomain_name" {
  description = "Server subdomain name (bigbluebutton)"
  default     = "server"
}

variable "bigbluebutton_count" {
  description = "Number of bigbluebutton servers"
  default     = 1
}

variable "bigbluebutton_security_group_name" {
  description = "Name for bigbluebutton security group"
  default     = "bigbluebutton-security-group"
}

variable "bigbluebutton_volume_size" {
  description = "Volume size in GiB (bigbluebutton)"
  default     = 80
}

variable "scalelite_instance_type" {
  description = "EC2 instance type (scalelite)"
  default     = "t3.medium"
}

variable "scalelite_aws_ami" {
  description = "EC2 instance AMI (scalelite)"
  default     = "ami-07df16d0682f1fa59"
}

variable "scalelite_domain_name" {
  description = "Server domain name (scalelite)"
  default     = "example.com"
}

variable "scalelite_subdomain_name" {
  description = "Server subdomain name (scalelite)"
  default     = null
}

variable "scalelite_security_group_name" {
  description = "Name for scalelite security group"
  default     = "scalelite-security-group"
}

variable "scalelite_volume_size" {
  description = "Volume size in GiB (scalelite)"
  default     = 50
}

variable "scalelite_url" {
  description = "scalelite_url"
}

variable "secret_key_base" {
  description = "secret_key_base"
}

variable "scalelite_secret" {
  description = "scalelite_secret"
}

variable "nginx_ssl" {
  description = "nginx_ssl"
}

variable "email" {
  description = "email"
}

variable "region" {
  description = "region"
}


variable "spot_price" {
  description = "spot price"
}