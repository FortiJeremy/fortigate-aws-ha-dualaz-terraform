<h1>fortigate-aws-ha-dualaz-terraform</h1>

<h2>AWS Authentication</h2>

This terraform deployment uses AWS provider authentication best practices and does not use hardcoded credentials. To authenticate with AWS, you can use any of the following methods:

1. Environment variables:
   ```
   $env:AWS_ACCESS_KEY_ID="your_access_key"
   $env:AWS_SECRET_ACCESS_KEY="your_secret_key"
   $env:AWS_REGION="your_region"
   ```

2. Shared AWS credentials file:
   - Configure a profile in `~/.aws/credentials` and optionally specify a profile using the AWS_PROFILE environment variable

3. IAM Instance Profile:
   - When running on AWS resources with attached IAM roles

4. AWS SSO:
   - Configure AWS SSO in your AWS CLI

For more details, see the [AWS_AUTHENTICATION.md](./AWS_AUTHENTICATION.md) file and the [AWS Provider Authentication documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).

<h2>IP Address Management</h2>

This module uses dynamic IP address calculation with Terraform's `cidrsubnet` and `cidrhost` functions. All IP addresses are derived from the VPC CIDR blocks, eliminating hardcoded IP addresses. Local variables improve readability and maintainability of these calculations.

For details, see [IP_ADDRESS_MANAGEMENT.md](./IP_ADDRESS_MANAGEMENT.md) file.

<h2>Module Architecture</h2>

The Terraform modules have been structured to avoid circular dependencies:
- The security-vpc module creates network infrastructure (VPC, subnets, route tables)
- The fgcp-ha module creates FortiGate instances, ENIs, and routes
- Subnet CIDRs are used directly from the VPC module outputs for IP calculations

For details about the module architecture, see [MODULE_REFACTORING.md](./MODULE_REFACTORING.md).

<h2>Version Constraints and Best Practices</h2>

This project uses specific version constraints for Terraform and the AWS provider to ensure compatibility and stability. All outputs include descriptions for better documentation, and local variables have been implemented to improve code readability.

For details, see [VERSION_CONSTRAINTS.md](./VERSION_CONSTRAINTS.md).

<h3>To view the workshop, please go here: <a href="https://fortinetcloudcse.github.io/fortigate-aws-ha-dualaz-terraform/">fortigate-aws-ha-dualaz-terraform</a></h3><hr><h3>For more information on creating these workshops, please go here: <a href="https://fortinetcloudcse.github.io/UserRepo/">FortinetCloudCSE User Repo</a></h3>