# IP Address Management

This module uses Terraform's `cidrsubnet` and `cidrhost` functions to dynamically calculate all IP addresses based on the VPC CIDR block. This eliminates the need for manually specifying subnet and host IP addresses, ensuring consistency and reducing configuration errors.

## Subnet Allocation

The VPC CIDR block is divided into 8 subnets (using a 3-bit subnet mask increment):

| Subnet | Index | Example (based on 10.0.0.0/16) |
|--------|-------|--------------------------------|
| public_subnet1     | 0 | 10.0.0.0/19 |
| public_subnet2     | 1 | 10.0.32.0/19 |
| private_subnet1    | 2 | 10.0.64.0/19 |
| private_subnet2    | 3 | 10.0.96.0/19 |
| hamgmt_subnet1     | 4 | 10.0.128.0/19 |
| hamgmt_subnet2     | 5 | 10.0.160.0/19 |
| tgwattach_subnet1  | 6 | 10.0.192.0/19 |
| tgwattach_subnet2  | 7 | 10.0.224.0/19 |

## Host IP Assignment

Host IP addresses are calculated systematically from the subnet CIDRs:

| Host | IP Assignment | Example |
|------|---------------|---------|
| AWS Router (each subnet) | First IP (.1) | 10.0.0.1, 10.0.32.1, etc. |
| FortiGate 1 | IP .11 in each subnet | 10.0.0.11, 10.0.64.11, 10.0.128.11 |
| FortiGate 2 | IP .11 in each subnet | 10.0.32.11, 10.0.96.11, 10.0.160.11 |

## Dynamic Calculation

All IP addresses are calculated using this pattern:
```terraform
# Router IPs (first IP in subnet)
public_subnet1_intrinsic_router_ip = cidrhost(module.security-vpc.public_subnet1_cidr, 1)

# FortiGate IPs (IP .11 in each subnet)
fgt1_public_ip = "${cidrhost(module.security-vpc.public_subnet1_cidr, 11)}/${split("/", module.security-vpc.public_subnet1_cidr)[1]}"
```

This approach ensures:
1. All IP addresses are derived automatically from the subnet CIDRs
2. Subnet masks are derived directly from the subnet CIDRs, not hardcoded
3. Consistent allocation across environments
4. No hardcoded IP addresses or subnet masks in the configuration
5. Easier scaling and modification
6. Using module outputs for subnet CIDRs improves readability and maintenance

## Local Variables for Enhanced Readability

The code uses local variables to improve readability and maintainability:

```terraform
locals {
  # FortiGate host number in each subnet
  fgt_host_number = 11
  
  # Router is always the first host (.1) in each subnet
  router_host_number = 1
  
  # Calculate subnet masks
  public_subnet1_mask = split("/", module.security-vpc.public_subnet1_cidr)[1]
  private_subnet1_mask = split("/", module.security-vpc.private_subnet1_cidr)[1]
  # ... additional subnet masks
  
  # TGW resources conditional access
  tgw_id = var.tgw_creation == "yes" ? module.transit-gw[0].tgw_id : ""
  # ... additional TGW resources
}
```

This approach:
1. Makes the code more self-documenting
2. Centralizes common calculations and values
3. Reduces repetition and potential for errors
4. Makes future maintenance easier

## Module Structure

The module structure has been optimized to avoid circular dependencies:

1. The security-vpc module creates all subnet resources and route tables
2. The fgcp-ha module creates the FortiGate instances and network interfaces
3. The fgcp-ha module also manages all route configurations that point to FortiGate ENIs
4. IP addresses are calculated using the subnet CIDRs output from the security-vpc module

This approach allows for direct use of the subnet CIDRs from the VPC module outputs without circular dependencies.
