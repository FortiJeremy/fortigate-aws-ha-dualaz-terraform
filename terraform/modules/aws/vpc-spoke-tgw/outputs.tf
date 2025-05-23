output "vpc_id" {
  description = "ID of the spoke VPC"
  value = aws_vpc.vpc.id
}

output "private_subnet1_id" {
  description = "ID of the first private subnet in the spoke VPC"
  value = aws_subnet.private_subnet1.id
}

output "private_subnet2_id" {
  description = "ID of the second private subnet in the spoke VPC"
  value = aws_subnet.private_subnet2.id
}