output "bbb_nic_id" {
  value = aws_network_interface.bbb_nic.id
}

output "gw" {
    value = aws_internet_gateway.gw
}