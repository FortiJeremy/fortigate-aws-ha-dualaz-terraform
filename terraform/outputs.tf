output "fgt_login_info" {
  value = <<-FGTLOGIN
  # fgt username: admin
  # fgt initial password: ${module.fgcp-ha.fgt1_id}
  # cluster login url: https://${module.fgcp-ha.cluster_eip_public_ip}
  
  # fgt1 login url: https://${module.fgcp-ha.fgt1_hamgmt_ip}
  # fgt2 login url: https://${module.fgcp-ha.fgt2_hamgmt_ip}
  FGTLOGIN
}

output "tgw_info" {
  value =  var.tgw_creation == "no" ? "tgw_creation = no" : <<-TGWINFO
  # tgw id: ${module.transit-gw[0].tgw_id}
  # tgw spoke route table id: ${module.transit-gw[0].tgw_spoke_route_table_id}
  # tgw security route table id: ${module.transit-gw[0].tgw_security_route_table_id}
  TGWINFO
}