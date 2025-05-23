terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider configuration
provider "aws" {
  region = var.region
  
  # No hard-coded credentials
  # Authentication will be handled by one of the following methods (in order of precedence):
  # 1. Environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
  # 2. Shared credentials file (~/.aws/credentials)
  # 3. AWS IAM Instance Profile (when running on EC2, ECS, Lambda, etc.)
  # 4. AWS SSO
  # 5. AWS CLI configured profiles
}
