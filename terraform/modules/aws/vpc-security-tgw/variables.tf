variable "region" {}
variable "availability_zone1" {}
variable "availability_zone2" {}
variable "vpc_cidr" {
  description = "CIDR block for the VPC. All subnet CIDRs will be calculated from this."
}
variable "fgt1_eni1_id" {}
variable "tag_name_prefix" {}
variable "tag_name_unique" {}
variable "tgw_creation" {}
variable "transit_gateway_id" {}
variable "tgw_security_route_table_id" {}
variable "tgw_spoke_route_table_id" {}