output "fgt1_id" {
  description = "Instance ID of the first FortiGate VM"
  value = aws_instance.fgt1.id
}

output "fgt2_id" {
  description = "Instance ID of the second FortiGate VM"
  value = aws_instance.fgt2.id
}

output "cluster_eip_public_ip" {
  description = "Public IP address of the cluster elastic IP"
  value = aws_eip.cluster_eip.public_ip
}

output "fgt1_hamgmt_ip" {
  description = "Public or private IP address of the first FortiGate's HA management interface"
  value = var.only_private_ec2_api == "false" ? aws_eip.fgt1_hamgmt_eip[0].public_ip : "${element("${split("/", var.fgt1_hamgmt_ip)}", 0)}"
}

output "fgt2_hamgmt_ip" {
  description = "Public or private IP address of the second FortiGate's HA management interface"
  value = var.only_private_ec2_api == "false" ? aws_eip.fgt2_hamgmt_eip[0].public_ip : "${element("${split("/", var.fgt2_hamgmt_ip)}", 0)}"
}

output "fgt1_eni1_id" {
  description = "ID of the first FortiGate's primary network interface"
  value = aws_network_interface.fgt1_eni1.id
}