# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.4.0] - 2023-09-19

### Added

- Add network policies (`CiliumNetworkPolicy` objects depend on `ciliumNetworkPolicy.enabled`)

### Changed

- Upgrade to cluster-api-provider-aws v2.2.1
- Switch to using Giant Swarm cluster-api-provider-aws fork's GitHub releases to make things consistent with the cluster-api fork

## [2.3.0] - 2023-07-14

### Fixed

- Add necessary values for PSS policy warnings

### Added

- Add common labels to pods so that Hubble shows the app name

## [2.2.0] - 2023-04-19

### Changed

- Change default registry in Helm chart from quay.io to docker.io.

## [2.1.0] - 2023-03-31

### Added

- Enabled Flatcar ignition bootstrap feature gate.

## [2.0.2] - 2023-03-22

### Added

- Added `node-role.kubernetes.io/control-plane` to crd install jobs toleration

## [2.0.1] - 2023-03-17

### Added

* Add psp and seccomp profile.

## [2.0.0] - 2023-03-02

### Changed

- Change `kubectl` image source to `giantswarm/kubectl`
- Bump `kubectl` version to `v1.24.10`
- Upgrade image and CRDs to a version newer than v2.0.2 (still including our `LoadBalancerReadyCondition` patch)

## [1.9.2] - 2023-01-19

### Changed

- Set Helm chart ownership to team hydra.
- Bumped controller to latest changes from upstream `release-1.5` branch

## [1.9.1] - 2022-11-30

### Changed

- Generation of Helm chart will fail if we get a 404 from Github.

### Fixed

- Re-generate helm chart after adading feature gate.

## [1.9.0] - 2022-11-30

### Changed

- Enabled external resource gc feature gate.

## [1.8.3] - 2022-11-22

## Fixed

- Switched to using fork-built image for `v1.5.2`. The fork contains a fix setting the LoadBalancerReadyCondition to Deleted

## [1.8.2] - 2022-11-21

### Fixed

- Switched to using upstream-built image for `v1.5.2`

## [1.8.1] - 2022-11-11

### Changed

- Upgraded image used to `v1.5.2-gs` (fork until upstream `1.5.2` release is available)

## [1.8.0] - 2022-11-03

### Added

- Add clusterctl labels to CRDs to support `clusterctl move`.

## [1.7.0] - 2022-10-18

### Changed

- Don't delete crd-install job when the `Job` fails so that we can inspect what happened.

## [1.6.0] - 2022-10-04

### Changed

- `PodSecurityPolicy` are removed on newer k8s versions, so only apply it in the `crd-install` job if object is registered in the k8s API.

## [1.5.0] - 2022-08-11

### Changed

- Bumped to cluster-api-provider-aws v1.5.0

## [1.2.3] - 2022-08-06

### Removed

- Remove ssh SSO public key value from the repository as its no longer used.

## [1.2.2] - 2022-08-05

## [1.2.1] - 2022-07-07

### Added

- Add VerticalPodAutoscaler CR.
- Value to set image registry domain

### Fixed

- Fix CRD path on `make` target.

## [1.2.0] - 2022-03-09

### Added

- Installing CRDs via crd-install job.
- Generating all manifests with kustomize by using upstream manifests a base and applying custom overlays.

### Removed

- Push to aws-app-collection.

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

[Unreleased]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.4.0...HEAD
[2.4.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.3.0...v2.4.0
[2.3.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.2.0...v2.3.0
[2.2.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.1.0...v2.2.0
[2.1.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.0.2...v2.1.0
[2.0.2]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.9.2...v2.0.0
[1.9.2]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.9.1...v1.9.2
[1.9.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.9.0...v1.9.1
[1.9.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.8.3...v1.9.0
[1.8.3]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.8.2...v1.8.3
[1.8.2]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.8.1...v1.8.2
[1.8.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.8.0...v1.8.1
[1.8.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.7.0...v1.8.0
[1.7.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.6.0...v1.7.0
[1.6.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.5.0...v1.6.0
[1.5.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.2.3...v1.5.0
[1.2.3]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.2.2...v1.2.3
[1.2.2]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.2.1...v1.2.2
[1.2.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v0.6.8-gs10...v1.2.0
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
