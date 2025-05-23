output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet1_cidr" {
  value = aws_subnet.public_subnet1.cidr_block
}

output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
}

output "public_subnet2_cidr" {
  value = aws_subnet.public_subnet2.cidr_block
}

output "private_subnet1_id" {
  value = aws_subnet.private_subnet1.id
}

output "private_subnet1_cidr" {
  value = aws_subnet.private_subnet1.cidr_block
}

output "private_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

output "private_subnet2_cidr" {
  value = aws_subnet.private_subnet2.cidr_block
}

output "hamgmt_subnet1_id" {
  value = aws_subnet.hamgmt_subnet1.id
}

output "hamgmt_subnet1_cidr" {
  value = aws_subnet.hamgmt_subnet1.cidr_block
}

output "hamgmt_subnet2_id" {
  value = aws_subnet.hamgmt_subnet2.id
}

output "hamgmt_subnet2_cidr" {
  value = aws_subnet.hamgmt_subnet2.cidr_block
}

output "private_rt_id" {
  value = aws_route_table.private_rt.id
}

output "tgwattach_rt_id" {
  value = var.tgw_creation == "yes" ? aws_route_table.tgwattach_rt[0].id : ""
}
