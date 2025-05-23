# AWS Authentication Guide

## Authentication Methods

This Terraform deployment uses AWS provider best practices for authentication, avoiding hardcoded credentials in the code. You can authenticate with AWS using any of the following methods (in order of precedence):

### 1. Environment Variables

Set the following environment variables:

#### PowerShell
```powershell
$env:AWS_ACCESS_KEY_ID="your_access_key"
$env:AWS_SECRET_ACCESS_KEY="your_secret_key"
$env:AWS_REGION="your_region"
```

#### Bash/Shell
```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_REGION="your_region"
```

### 2. Shared Credentials File

Create or edit the AWS credentials file:

- Windows: `%USERPROFILE%\.aws\credentials`
- Linux/macOS: `~/.aws/credentials`

```ini
[default]
aws_access_key_id=your_access_key
aws_secret_access_key=your_secret_key
region=your_region

[profile_name]
aws_access_key_id=your_access_key
aws_secret_access_key=your_secret_key
region=your_region
```

To use a specific profile:
```powershell
$env:AWS_PROFILE="profile_name"
```

### 3. IAM Instance Profile

When running Terraform on an EC2 instance, ECS task, or Lambda function, you can use an attached IAM role that has the necessary permissions.

### 4. AWS SSO

If your organization uses AWS SSO, configure it with the AWS CLI:

```bash
aws configure sso
```

## Security Best Practices

1. Use IAM roles with the principle of least privilege
2. Rotate access keys regularly
3. Consider using AWS Secrets Manager or HashiCorp Vault for sensitive credentials
4. Enable MFA for IAM users
5. Use temporary credentials when possible

## Troubleshooting

If you encounter authentication issues, verify the following:

1. Check that your credentials are valid and not expired
2. Ensure the IAM user/role has appropriate permissions
3. Validate AWS CLI configuration with `aws sts get-caller-identity`
4. Check file permissions on credentials files

For more details, see the [AWS Provider Authentication documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).
