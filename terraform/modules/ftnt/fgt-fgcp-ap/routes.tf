# Route table resources moved from security-vpc to fgcp-ha module
# Create default route in the private route table pointing to the FortiGate ENI
resource "aws_route" "private_route" {
  route_table_id = var.private_rt_id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id = aws_network_interface.fgt1_eni1.id
}

# Create default route in the TGW attachment route table (when using TGW)
resource "aws_route" "tgwattach_route" {
  count = var.tgw_creation == "yes" ? 1 : 0
  route_table_id = var.tgwattach_rt_id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id = aws_network_interface.fgt1_eni1.id
}

# Add a transit gateway route in the private route table (when using TGW)
resource "aws_route" "private_tgw_route" {
  count = var.tgw_creation == "yes" ? 1 : 0
  route_table_id = var.private_rt_id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id = var.transit_gateway_id
}
