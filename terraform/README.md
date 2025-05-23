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

For more details, see the [AWS Provider Authentication documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).

<h3>To view the workshop, please go here: <a href="https://fortinetcloudcse.github.io/fortigate-aws-ha-dualaz-terraform/">fortigate-aws-ha-dualaz-terraform</a></h3><hr><h3>For more information on creating these workshops, please go here: <a href="https://fortinetcloudcse.github.io/UserRepo/">FortinetCloudCSE User Repo</a></h3>