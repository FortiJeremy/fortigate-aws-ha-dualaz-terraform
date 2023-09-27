---
title: "Deployment"
chapter: false
menuTitle: "Deployment"
weight: 30
---

Once the prerequisites have been satisfied proceed with the deployment steps below.

1.  Clone this repo with the command below.
```
git clone https://github.com/hgaberra/fortigate-aws-ha-dualaz-terraform.git
```

2.  Change directories and modify the terraform.tfvars file with your credentials and deployment information. 

{{% notice note %}} In the terraform.tfvars file, the comments explain what inputs are expected for the variables. For further details on a given variable or to see all possible variables, reference the variables.tf file. {{% /notice %}}
```
cd fortigate-aws-ha-dualaz-terraform/terraform
nano terraform.tfvars
```

3.  When ready to deploy, use the commands below to run through the deployment.
```
terraform init
terraform apply --auto-approve
```

4.  When the deployment is complete, you will see login information for the FortiGates like so.
```
Apply complete! Resources: 37 added, 0 changed, 0 destroyed.

Outputs:

fgt_login_info = <<EOT

  # fgt username: admin
  # fgt initial password: i-02a665023769e127d
  # cluster login url: https://184.169.245.204
  
  # fgt1 login url: https://54.67.114.34
  # fgt2 login url: https://52.53.78.194
  
  # tgw_creation: no

EOT
```