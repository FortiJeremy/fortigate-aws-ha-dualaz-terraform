---
title: "Deployment"
chapter: false
menuTitle: "Deployment"
weight: 30
---

Once the prerequisites have been satisfied proceed with the deployment steps below.

1.  Clone this repo with the command below.
```
git clone https://github.com/FortinetCloudCSE/fortigate-aws-ha-dualaz-terraform.git
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
terraform validate
terraform apply --auto-approve
```

4.  When the deployment is complete, you will see login information for the FortiGates like so.
```
Apply complete! Resources: 33 added, 0 changed, 0 destroyed.

Outputs:

fgt_login_info = <<EOT

  # fgt username: admin
  # fgt initial password: i-0eb689028cc992e41
  # cluster login url: https://13.56.40.46
  
  # fgt1 login url: https://52.8.158.219
  # fgt2 login url: https://54.241.49.19
  
  # tgw_creation: no

EOT
```