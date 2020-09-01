

data "aws_route53_zone" "bigbluebutton" {
  name = var.domain_name
}

resource "aws_route53_record" "bigbluebutton" {
  zone_id = data.aws_route53_zone.bigbluebutton.zone_id
  name    = "${var.subdomain_name}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.bigbluebutton.public_ip]
}

# resource "aws_eip" "bigbluebutton" {
#   instance = aws_instance.bigbluebutton.id
#   vpc      = true

#   tags = {
#     terraform = true
#   }
# }

resource "aws_eip" "bigbluebutton" {
  vpc                       = true
  network_interface         = var.bbb_nic
  associate_with_private_ip = var.private_ip_instance
  depends_on = [var.gw]
}

data "template_file" "script" {
  template = "${file("../bbb_script.pl")}"
  vars = {
    region        = var.region
    url           = "${var.subdomain_name}.${var.domain_name}"
    email         = var.email
    shared_secret = file("../shared_secret")
  }
}

# resource "aws_instance" "bigbluebutton" {
#   instance_type = var.instance_type
#   ami           = var.aws_ami

#   key_name        = var.key_name
#   security_groups = [var.security_group_name]

#   user_data = data.template_file.script.rendered

#   ebs_block_device {
#     device_name = "/dev/sda1"
#     volume_type = "gp2"
#     volume_size = var.volume_size
#   }

#   tags = {
#     terraform = true
#   }
# }

resource "aws_spot_instance_request" "bigbluebutton" {

  ami                             = var.aws_ami
  instance_type                   = var.instance_type
  availability_zone               = var.availability_zone
  key_name                        = var.key_name
  security_groups                 = [var.security_group_name]
  spot_price                      = var.spot_price
  wait_for_fulfillment            = "true"
  spot_type                       = "one-time"
  instance_interruption_behaviour = "terminate"
# user_data = data.template_file.script.rendered
  tags = {
    terraform = true
  }
}

output "private_ip" {
  value = aws_spot_instance_request.bigbluebutton.private_ip
}

output "public_ip" {
  value = aws_eip.bigbluebutton.public_ip
}
