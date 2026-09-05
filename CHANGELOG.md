# Changelog

All notable changes to this module are documented here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and versions follow [Semantic Versioning](https://semver.org/).

## [2.0.5] - 2026-09-05

### Added

- terraform-docs-generated interface documentation in README (Requirements/Providers/Inputs/Outputs) with a CI drift check.

## [2.0.4] - 2026-09-05

### Added

- CHANGELOG.md.

## [2.0.3] - 2026-09-04

### Added

- CI workflow running `terraform fmt`, `terraform validate`, and tflint.
- Release workflow for tagging and publishing to the Terraform Registry.
- `.tflint.hcl` configuration.
- README badges.
- Committed `.terraform.lock.hcl` files (root and example).

### Changed

- AWS provider constraint from `~> 5.0` to `>= 5.0, < 7.0` (adds AWS provider v6 support).

## [2.0.2] - 2026-02-22

### Changed

- Added value-prop bullets and Registry badge to README.
- Added `## Examples` and `## Requirements` sections to README.
- Renamed `## Resources created` to `## What it creates`.
- Added `## License`.

## [2.0.1] - 2026-02-21

### Changed

- Migrated repository to `pomo-studio` GitHub organisation.
- Added README with full usage examples and v1→v2 migration guide with `moved` blocks.
- Published to Terraform Registry as `pomo-studio/oidc/aws`.

## [2.0.0] - 2026-02-21

### Added

- Initial release of OIDC module.
- Creates OIDC identity provider for any compliant provider.
- Supports multiple IAM roles with scoped trust policies.
- Configurable role permissions through inline policies.
- Comprehensive input validation.

> Historical releases are documented in [GitHub Releases](https://github.com/pomo-studio/terraform-aws-oidc/releases).
