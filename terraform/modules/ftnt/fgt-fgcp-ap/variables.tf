variable "region" {}
variable "availability_zone1" {}
variable "availability_zone2" {}
variable "vpc_id" {}
variable "vpc_cidr" {}
variable "public_subnet1_id" {}
variable "private_subnet1_id" {}
variable "hamgmt_subnet1_id" {}
variable "public_subnet2_id" {}
variable "private_subnet2_id" {}
variable "hamgmt_subnet2_id" {}
variable "instance_type" {}
variable "cidr_for_access" {}
variable "keypair" {}
variable "encrypt_volumes" {}
variable "only_private_ec2_api" {}
variable "fortios_version" {}
variable "license_type" {}
variable "fgt1_byol_license" {}
variable "fgt2_byol_license" {}
variable "fgt1_fortiflex_token" {}
variable "fgt2_fortiflex_token" {}
variable "public_subnet1_intrinsic_router_ip" {}
variable "private_subnet1_intrinsic_router_ip" {}
variable "hamgmt_subnet1_intrinsic_router_ip" {}
variable "public_subnet2_intrinsic_router_ip" {}
variable "private_subnet2_intrinsic_router_ip" {}
variable "hamgmt_subnet2_intrinsic_router_ip" {}
variable "fgt1_public_ip" {}
variable "fgt1_private_ip" {}
variable "fgt1_hamgmt_ip" {}
variable "fgt2_public_ip" {}
variable "fgt2_private_ip" {}
variable "fgt2_hamgmt_ip" {}
variable "tag_name_prefix" {}
variable "spoke_vpc1_cidr" {}
variable "spoke_vpc2_cidr" {}
variable "tgw_creation" {}
variable "transit_gateway_id" {
  default = ""
  description = "Transit Gateway ID, required only when tgw_creation is yes"
}
variable "private_rt_id" {
  description = "ID of the private route table from the security VPC"
}
variable "tgwattach_rt_id" {
  default = ""
  description = "ID of the TGW attachment route table, required only when tgw_creation is yes"
}
