terraform {
  required_version = ">=0.13.0"
}

provider "aws" {
  profile    = var.aws_profile
  region     = var.aws_region
  access_key = file("../access_key")
  secret_key = file("../secret_key")
}

module "bigbluebutton_instance" {
  source = "../modules/bigbluebutton"

  count               = var.bigbluebutton_count
  availability_zone   = var.availability_zone
  key_name            = var.key_name
  security_group_name = var.bigbluebutton_security_group_name
  instance_type       = var.bigbluebutton_instance_type
  aws_ami             = var.bigbluebutton_aws_ami
  domain_name         = var.bigbluebutton_domain_name
  subdomain_name      = "${var.bigbluebutton_subdomain_name}-${count.index}"
  volume_size         = var.bigbluebutton_volume_size
  region              = var.region
  email               = var.email
  bbb_spot_price      = var.bbb_spot_price
}

module "scalelite_instance" {
  source = "../modules/scalelite"

  key_name            = var.key_name
  security_group_name = var.scalelite_security_group_name
  instance_type       = var.scalelite_instance_type
  aws_ami             = var.scalelite_aws_ami
  availability_zone   = var.availability_zone
  scale_spot_price    = var.scale_spot_price
  domain_name         = var.scalelite_domain_name
  subdomain_name      = var.scalelite_subdomain_name
  bbb_domain_name     = var.bigbluebutton_domain_name
  bbb_subdomain_name  = var.bigbluebutton_subdomain_name
  volume_size         = var.scalelite_volume_size
  secret_key_base     = file("../secret_key_base")
  scalelite_secret    = file("../scalelite_secret_key")
  scalelite_url       = var.scalelite_url
  nginx_ssl           = var.nginx_ssl
}
