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
  type        = any
}

variable "key_name" {
  description = "Name for your SSH public key"
  type        = string
}

variable "volume_size" {
  description = "Volume size in GiB"
  type        = number
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

variable "availability_zone" {
  description = "availability_zone"
}

variable "scale_spot_price" {
  description = "bbb_Spot_price"
}

variable "bbb_subdomain_name" {
  description = "bbb subdomain name"
}

variable "bbb_domain_name" {
  description = "bbb domain name"
}

data "aws_route53_zone" "scalelite" {
  name = var.domain_name
}

resource "aws_route53_record" "scalelite" {
  zone_id = data.aws_route53_zone.scalelite.zone_id
  name    = ((var.subdomain_name == null) ? var.domain_name : "${var.subdomain_name}.${var.domain_name}")
  type    = "A"
  ttl     = "300"
  records = [aws_eip.scalelite.public_ip]
}

resource "aws_eip" "scalelite" {
  instance = aws_spot_instance_request.scalelite.spot_instance_id
  vpc      = true

  tags = {
    terraform = true
  }
}

data "template_file" "script" {
  template = "${file("../scalelite_script.pl")}"
  vars = {
    scalelite_url    = var.scalelite_url
    secret_key_base  = var.secret_key_base
    scalelite_secret = var.scalelite_secret
    nginx_ssl        = var.nginx_ssl
    bbb_subdomain    = var.bbb_subdomain_name
    bbb_domain       = var.bbb_domain_name
    shared_secret = file("../shared_secret")
  }
}

# resource "aws_instance" "scalelite" {
#   instance_type = var.instance_type
#   ami           = var.aws_ami

#   key_name        = var.key_name
#   security_groups = [var.security_group_name]

#     user_data = data.template_file.script.rendered

#   ebs_block_device {
#     device_name = "/dev/sda1"
#     volume_type = "gp2"
#     volume_size = var.volume_size
#   }


#   tags = {
#     terraform = true
#   }
# }

resource "aws_spot_instance_request" "scalelite" {

  ami                             = var.aws_ami
  instance_type                   = var.instance_type
  availability_zone               = var.availability_zone
  key_name                        = var.key_name
  security_groups                 = [var.security_group_name]
  spot_price                      = var.scale_spot_price
  wait_for_fulfillment            = "true"
  spot_type                       = "one-time"
  instance_interruption_behaviour = "terminate"
  user_data                       = data.template_file.script.rendered
  tags = {
    terraform = true
  }
}

# output "private_ip" {
#   value = aws_instance.scalelite.private_ip
# }

output "private_ip" {
  value = aws_spot_instance_request.scalelite.private_ip
}

output "public_ip" {
  value = aws_eip.scalelite.public_ip
}
