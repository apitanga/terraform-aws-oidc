# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.2] - 2026-02-22

### Changed
- Added value-prop bullets and Registry badge to README
- Added `## Examples` and `## Requirements` sections to README
- Renamed `## Resources created` to `## What it creates`
- Added `## License`

## [2.0.1] - 2026-02-21

### Changed
- Migrated repository to `pomo-studio` GitHub organisation
- Added README with full usage examples and v1→v2 migration guide with `moved` blocks
- Published to Terraform Registry as `pomo-studio/oidc/aws`

## [2.0.0] - 2026-02-21

### Added
- Initial release of OIDC module
- Creates OIDC identity provider for any compliant provider
- Supports multiple IAM roles with scoped trust policies
- Configurable role permissions through inline policies
- Comprehensive input validation

### Features
- **Flexible configuration**: One module call per OIDC provider, multiple roles
- **Secure defaults**: Least-privilege IAM policies
- **Production-ready**: Input validation prevents misconfiguration
- **Multi-provider support**: GitHub Actions, Terraform Cloud, GitLab, etc.

### Usage Example
```hcl
module "tfc_oidc" {
  source  = "pomo-studio/oidc/aws"
  version = "~> 2.0"

  provider_url    = "https://app.terraform.io"
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]

  roles = {
    deploy = {
      policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
    read_only = {
      policy_json = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect   = "Allow"
            Action   = ["s3:GetObject", "s3:ListBucket"]
            Resource = "*"
          }
        ]
      })
    }
  }
}
```

### Breaking Changes
This is the initial release. No breaking changes from previous versions.

[2.0.0]: https://github.com/pomo-studio/terraform-aws-oidc/releases/tag/v2.0.0