# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.6.8-gs10-crd] - 2021-11-24

## [0.6.8-gs10] - 2021-11-24

### Fixed

- Fix selector labels for EKS webhook.

## [0.6.8-gs9] - 2021-11-24

### Fixed

- Fix match labels to be unique for all deployments and services.

## [0.6.8-gs8] - 2021-10-11

## [0.6.8-gs7] - 2021-10-11

## [0.6.8-gs6] - 2021-10-11

### Changed

- Fix chart uniqueness.
- Enable EKS in CAPA webhook

## [0.6.8-gs5] - 2021-09-09

### Changed

- Fix labels for all deployment and services.

## [0.6.8-gs4] - 2021-09-02

### Changed

- Moving helm templating to new config management.

## [0.6.8-gs3] - 2021-08-31

### Changed

- Deactivate eks flag only for core aws webhook


## [0.6.8-gs2] - 2021-08-25

### Changed

- Activated eks feature flags

## [0.6.8-gs1] - 2021-08-02

- Updated CAPA to v0.6.8.

## [0.6.6-gs2] - 2021-07-28

### Added

- Add secret to store ssh sso public key for later use.

## [0.6.6-gs1] - 2021-06-25

### Changed

- Updated CAPA to version to 0.6.6

### Removed

- Remove kube-rbac-proxy for the metrics endpoint.

## [0.6.5-gs3] - 2021-05-27

### Changed

- Changed watch-filter value to `capi`.

## [0.6.5-gs2] - 2021-05-24

## [0.6.5-gs1] - 2021-05-12

## [0.0.1] - 2021-03-18

[Unreleased]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs10-crd...HEAD
[0.6.8-gs10-crd]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs10...v0.6.8-gs10-crd
[0.6.8-gs10]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs9...v0.6.8-gs10
[0.6.8-gs9]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs8...v0.6.8-gs9
[0.6.8-gs8]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs7...v0.6.8-gs8
[0.6.8-gs7]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs6...v0.6.8-gs7
[0.6.8-gs6]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs5...v0.6.8-gs6
[0.6.8-gs5]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs4...v0.6.8-gs5
[0.6.8-gs4]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs3...v0.6.8-gs4
[0.6.8-gs3]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs2...v0.6.8-gs3
[0.6.8-gs2]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs1...v0.6.8-gs2
[0.6.8-gs1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.6-gs2...v0.6.8-gs1
[0.6.6-gs2]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.9-gs1...v0.6.6-gs2
[0.6.5-gs3]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.5-gs2...v0.6.5-gs3
[0.6.5-gs2]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.5-gs1...v0.6.5-gs2
[0.6.5-gs1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.0.1...v0.6.5-gs1
[0.0.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/releases/tag/v0.0.1
