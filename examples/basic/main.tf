terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Terraform Cloud OIDC — provider + roles
module "tfc_oidc" {
  source  = "pomo-studio/oidc/aws"
  version = "~> 2.0"

  provider_url    = "https://app.terraform.io"
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]

  roles = {
    staging = {
      role_name = "terraform-cloud-staging"
      oidc_conditions = [
        { test = "StringEquals", variable = "app.terraform.io:aud", values = ["aws.workload.identity"] },
        { test = "StringLike", variable = "app.terraform.io:sub", values = ["organization:my-org:project:*:workspace:staging:run_phase:*"] }
      ]
      policy_json = data.aws_iam_policy_document.staging.json
    }
  }
}

# GitHub Actions OIDC — provider + roles
module "github_oidc" {
  source  = "pomo-studio/oidc/aws"
  version = "~> 2.0"

  provider_url    = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]

  roles = {
    my-app = {
      role_name = "github-actions-my-app"
      oidc_conditions = [
        { test = "StringEquals", variable = "token.actions.githubusercontent.com:aud", values = ["sts.amazonaws.com"] },
        { test = "StringLike", variable = "token.actions.githubusercontent.com:sub", values = ["repo:my-org/my-app:*"] }
      ]
      policy_json = data.aws_iam_policy_document.deploy.json
    }
  }
}

# Example policy documents
data "aws_iam_policy_document" "staging" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::my-staging-*", "arn:aws:s3:::my-staging-*/*"]
  }
}

data "aws_iam_policy_document" "deploy" {
  statement {
    effect    = "Allow"
    actions   = ["lambda:UpdateFunctionCode", "s3:PutObject"]
    resources = ["*"]
  }
}
