terraform {
  required_version = ">=0.13.0"
}

provider "aws" {
  profile    = var.aws_profile
  region     = var.aws_region
  access_key = file("../access_key")
  secret_key = file("../secret_key")
}

module "bootstrap" {
  source                            = "../modules/bootstrap"
  bigbluebutton_security_group_name = var.bigbluebutton_security_group_name
  scalelite_security_group_name     = var.scalelite_security_group_name
 # private_ip_instances              = var.private_ip_instances
  subnet_prefix                     = var.subnet_prefix
  availability_zone                 = var.availability_zone
}

module "bigbluebutton_instance" {
  source              = "../modules/bigbluebutton"
  count               = var.bigbluebutton_count
  key_name            = var.key_name
  availability_zone   = var.availability_zone
  
  security_group_name = var.bigbluebutton_security_group_name
  instance_type       = var.bigbluebutton_instance_type
  aws_ami             = var.bigbluebutton_aws_ami
  domain_name         = var.bigbluebutton_domain_name
  subdomain_name      = "${var.bigbluebutton_subdomain_name}-${count.index}"
  volume_size         = var.bigbluebutton_volume_size
  region              = var.region
  email               = var.email
  spot_price          = var.spot_price
  
  #private_ip_instance = element(var.private_ip_instances, (count.index))
  gw                  = module.bootstrap.gw
  vpc_security_group_id = module.bootstrap.vpc_security_group_id
}

module "scalelite_instance" {
  source = "../modules/scalelite"

  key_name            = var.key_name
  security_group_name = var.scalelite_security_group_name
  instance_type       = var.scalelite_instance_type
  aws_ami             = var.scalelite_aws_ami
  domain_name         = var.scalelite_domain_name
  subdomain_name      = var.scalelite_subdomain_name
  volume_size         = var.scalelite_volume_size
  secret_key_base     = var.secret_key_base
  scalelite_secret    = var.scalelite_secret
  scalelite_url       = var.scalelite_url
  nginx_ssl           = var.nginx_ssl
}
