

output "vpc_id" {
  value = aws_default_vpc.default.id
}


output "gw" {
    value = aws_internet_gateway.gw
}



output "vpc_security_group_id" {
    value = aws_security_group.bigbluebutton.id
}

output "scale_vpc_security_group_id" {
    value = aws_security_group.scalelite.id
}