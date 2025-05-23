module "transit-gw" {
  source = ".//modules/aws/tgw"
  count = var.tgw_creation == "yes" ? 1 : 0
  region = var.region
  tag_name_prefix = var.tag_name_prefix
}

module "security-vpc" {
  source = ".//modules/aws/vpc-security-tgw"
  region = var.region
  
  availability_zone1 = var.availability_zone1
  availability_zone2 = var.availability_zone2
  vpc_cidr = var.security_vpc_cidr
  # Removed fgt1_eni1_id as it's no longer needed in this module
  tgw_creation = var.tgw_creation
  transit_gateway_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_id : ""
  tgw_spoke_route_table_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_spoke_route_table_id : ""
  tgw_security_route_table_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_security_route_table_id : ""
  tag_name_prefix = var.tag_name_prefix
  tag_name_unique = "security"
}

module "fgcp-ha" {
  source = ".//modules/ftnt/fgt-fgcp-ap"
  region = var.region
  depends_on = [module.security-vpc] # Ensure VPC is fully created before starting FortiGate deployment

  availability_zone1 = var.availability_zone1
  availability_zone2 = var.availability_zone2
  vpc_id = module.security-vpc.vpc_id
  vpc_cidr = var.security_vpc_cidr
  public_subnet1_id = module.security-vpc.public_subnet1_id
  private_subnet1_id = module.security-vpc.private_subnet1_id
  hamgmt_subnet1_id = module.security-vpc.hamgmt_subnet1_id
  public_subnet2_id = module.security-vpc.public_subnet2_id
  private_subnet2_id = module.security-vpc.private_subnet2_id
  hamgmt_subnet2_id = module.security-vpc.hamgmt_subnet2_id
  
  # Add route table IDs
  private_rt_id = module.security-vpc.private_rt_id
  tgwattach_rt_id = var.tgw_creation == "yes" ? module.security-vpc.tgwattach_rt_id : ""
  transit_gateway_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_id : ""

  cidr_for_access = var.cidr_for_access
  keypair = var.keypair
  encrypt_volumes = var.encrypt_volumes
  instance_type = var.instance_type
  only_private_ec2_api = var.only_private_ec2_api
  fortios_version = var.fortios_version
  license_type = var.license_type
  fgt1_byol_license = var.fgt1_byol_license
  fgt2_byol_license = var.fgt2_byol_license
  fgt1_fortiflex_token = var.fgt1_fortiflex_token
  fgt2_fortiflex_token = var.fgt2_fortiflex_token  
  # Calculate router IPs - router is always the first host (.1) in each subnet
  public_subnet1_intrinsic_router_ip = cidrhost(module.security-vpc.public_subnet1_cidr, 1)
  private_subnet1_intrinsic_router_ip = cidrhost(module.security-vpc.private_subnet1_cidr, 1)
  hamgmt_subnet1_intrinsic_router_ip = cidrhost(module.security-vpc.hamgmt_subnet1_cidr, 1)
  public_subnet2_intrinsic_router_ip = cidrhost(module.security-vpc.public_subnet2_cidr, 1)
  private_subnet2_intrinsic_router_ip = cidrhost(module.security-vpc.private_subnet2_cidr, 1)
  hamgmt_subnet2_intrinsic_router_ip = cidrhost(module.security-vpc.hamgmt_subnet2_cidr, 1)
  tag_name_prefix = var.tag_name_prefix

  # Calculate FortiGate IPs - host .11 in each subnet with /24 netmask
  fgt1_public_ip = "${cidrhost(module.security-vpc.public_subnet1_cidr, 11)}/24"
  fgt1_private_ip = "${cidrhost(module.security-vpc.private_subnet1_cidr, 11)}/24"
  fgt1_hamgmt_ip = "${cidrhost(module.security-vpc.hamgmt_subnet1_cidr, 11)}/24"

  fgt2_public_ip = "${cidrhost(module.security-vpc.public_subnet2_cidr, 11)}/24"
  fgt2_private_ip = "${cidrhost(module.security-vpc.private_subnet2_cidr, 11)}/24"
  fgt2_hamgmt_ip = "${cidrhost(module.security-vpc.hamgmt_subnet2_cidr, 11)}/24"

  tgw_creation = var.tgw_creation
  spoke_vpc1_cidr = var.spoke_vpc1_cidr
  spoke_vpc2_cidr = var.spoke_vpc2_cidr
}

module "spoke-vpc1" {
  source = ".//modules/aws/vpc-spoke-tgw"
  count = var.tgw_creation == "yes" ? 1 : 0
  region = var.region
  
  availability_zone1 = var.availability_zone1
  availability_zone2 = var.availability_zone2
  vpc_cidr = var.spoke_vpc1_cidr
  transit_gateway_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_id : ""
  tgw_spoke_route_table_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_spoke_route_table_id : ""
  tgw_security_route_table_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_security_route_table_id : ""
  tag_name_prefix = var.tag_name_prefix
  tag_name_unique = "spoke1"
}

module "spoke-vpc2" {
  source = ".//modules/aws/vpc-spoke-tgw"
  count = var.tgw_creation == "yes" ? 1 : 0
  region = var.region
  
  availability_zone1 = var.availability_zone1
  availability_zone2 = var.availability_zone2
  vpc_cidr = var.spoke_vpc2_cidr
  transit_gateway_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_id : ""
  tgw_spoke_route_table_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_spoke_route_table_id : ""
  tgw_security_route_table_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_security_route_table_id : ""
  tag_name_prefix = var.tag_name_prefix
  tag_name_unique = "spoke2"
}
