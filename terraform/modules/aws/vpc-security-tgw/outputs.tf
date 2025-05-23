output "vpc_id" {
  description = "ID of the security VPC"
  value = aws_vpc.vpc.id
}

output "public_subnet1_id" {
  description = "ID of the first public subnet in the security VPC"
  value = aws_subnet.public_subnet1.id
}

output "public_subnet1_cidr" {
  description = "CIDR block of the first public subnet in the security VPC"
  value = aws_subnet.public_subnet1.cidr_block
}

output "public_subnet2_id" {
  description = "ID of the second public subnet in the security VPC"
  value = aws_subnet.public_subnet2.id
}

output "public_subnet2_cidr" {
  description = "CIDR block of the second public subnet in the security VPC"
  value = aws_subnet.public_subnet2.cidr_block
}

output "private_subnet1_id" {
  description = "ID of the first private subnet in the security VPC"
  value = aws_subnet.private_subnet1.id
}

output "private_subnet1_cidr" {
  description = "CIDR block of the first private subnet in the security VPC"
  value = aws_subnet.private_subnet1.cidr_block
}

output "private_subnet2_id" {
  description = "ID of the second private subnet in the security VPC"
  value = aws_subnet.private_subnet2.id
}

output "private_subnet2_cidr" {
  description = "CIDR block of the second private subnet in the security VPC"
  value = aws_subnet.private_subnet2.cidr_block
}

output "hamgmt_subnet1_id" {
  description = "ID of the first HA management subnet in the security VPC"
  value = aws_subnet.hamgmt_subnet1.id
}

output "hamgmt_subnet1_cidr" {
  description = "CIDR block of the first HA management subnet in the security VPC"
  value = aws_subnet.hamgmt_subnet1.cidr_block
}

output "hamgmt_subnet2_id" {
  description = "ID of the second HA management subnet in the security VPC"
  value = aws_subnet.hamgmt_subnet2.id
}

output "hamgmt_subnet2_cidr" {
  description = "CIDR block of the second HA management subnet in the security VPC"
  value = aws_subnet.hamgmt_subnet2.cidr_block
}

output "private_rt_id" {
  description = "ID of the private subnet route table in the security VPC"
  value = aws_route_table.private_rt.id
}

output "tgwattach_rt_id" {
  description = "ID of the Transit Gateway attachment subnet route table in the security VPC (empty if TGW is not created)"
  value = var.tgw_creation == "yes" ? aws_route_table.tgwattach_rt[0].id : ""
}
