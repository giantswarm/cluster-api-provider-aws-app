# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Bump CAPA version v2.4.2-gs-70b4664c1. This bumps CAPA to `v2.4.2` and apply the customizations we already had in our fork.

## [2.19.1] - 2024-06-25

### Fixed

- Fix for the new feature of writing user data to S3 bucket for `AWSMachinePool`: on cluster deletion, delete machine pool user data files that did not get deleted yet by the S3 bucket lifecycle policy. Otherwise, CAPA would have left the S3 bucket behind on deletion since it was not empty.

## [2.19.0] - 2024-06-06

### Added

- Support for writing user data to S3 bucket for `AWSMachinePool`

## [2.18.1] - 2024-05-24

### Changed

- Make ServiceMonitor optional through `serviceMonitor.enabled` helm value (useful in mc-bootstrap).

## [2.18.0] - 2024-05-02

### Added

- Support adding custom secondary VPC CIDR blocks in `AWSCluster` (backport)

## [2.17.0] - 2024-04-25

### Added

- Bump CAPA version v2.3.0-gs-16d1f6ed4. Introduces the `NonRootVolumes` field to AWSMachinePools and AWSManagedMachinePools.

## [2.16.0] - 2024-04-17

### Fixed

- Bump CAPA version v2.3.0-gs-784b17920. This fixes controller not adding ID to secondary subnet when updating AWSCluster.

### Changed

- Add toleration for `node.cluster.x-k8s.io/uninitialized` taint.
- Remove toleration for old `node-role.kubernetes.io/master` taint.

## [2.15.2] - 2024-04-02

### Fixed

- Fix CRD installation job's settings so it can get admitted by Kyverno policies

## [2.15.1] - 2024-04-02

### Added

- Add ServiceMonitor for monitoring.

### Changed

- Change container image registry values name to use values from `config` repo.

## [2.15.0] - 2024-02-20

### Changed

- Bump version to `v2.3.0-gs-e9c5ab62c`. This version prevents EKS nodes from landing in the CNI subnets.

## [2.14.0] - 2024-02-07

### Changed

- Use `app-build-suite` to build the app
- Bump version to `v2.3.0-gs-3e18e8bef`. This version adds the `DefaultInstanceWarmup` field to AWSMachinePools.

## [2.13.0] - 2024-01-23

### Changed

- Backport feature: expose new field to secure VPC default security group)[https://github.com/kubernetes-sigs/cluster-api-provider-aws/pull/4707].

## [2.12.0] - 2024-01-18

### Changed

- Delete aws-node resources even when they have `Helm` labels when `AWSManagedControlPlane.spec.VpcCni.disabled` is set to `true`.

## [2.11.0] - 2024-01-15

### Changed

- Update CRDs to make the subnet `id` field required again

## [2.10.1] - 2024-01-10

### Changed

- Switch to image hosted on gsoci.azurecr.io

## [2.10.0] - 2024-01-10

### Changed

- Backported fixes and features for CAPA v2.3.x

  - Use go 1.21.5, fix kubectl version detection after `--short` parameter was removed
  - Make VPC creation idempotent to avoid indefinite creation of new VPCs if storage of the ID fails
  - Log full ARN in GC error messages
  - Fix deregistering of deleted CAPI Machines
  - ASG: do not set desired value for machinepool which have externally managed replicas

## [2.9.0] - 2023-12-21

### Changed

- Backported fixes and features for CAPA v2.3.x

  - Enable transit encryption to S3 bucket
  - Trigger machine pool instance refresh (node rollout) if bootstrap config reference changes
  - Skip instance refresh attempt if ASG does not yet exist

## [2.8.1] - 2023-12-14

### Fixed

- Revert CRDs upgrade since CAPA creates unlimited VPCs for EKS clusters because the subnet `id` field cannot be set ([bug](https://github.com/giantswarm/roadmap/issues/3048))

## [2.8.0] - 2023-12-13

### Changed

- Upgrade CAPA CRDs to v2.3.0 including required subnet `id` field

## [2.7.1] - 2023-12-07

### Changed

- Configure `gsoci.azurecr.io` as the default container image registry.

## [2.7.0] - 2023-11-30

### Changed

- Upgrade CAPA to v2.3.0 but comment out CRD upgrade so existing clusters reconcile fine without having the newly-required subnet `id` field yet

## [2.6.1] - 2023-11-13

### Added

- Bump to CAPA version with the backported feature "Use `AdditionalTags` for S3 buckets"

## [2.6.0] - 2023-11-08

### Added

- Add `global.podSecurityStandards.enforced` value for PSS migration.
- Bump to CAPA version with the backported feature "Tag S3 bucket as owned by cluster"

## [2.5.0] - 2023-10-09

### Changed

- Upgraded to CAPA v2.2.4.

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

[Unreleased]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.19.1...HEAD
[2.19.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.19.0...v2.19.1
[2.19.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.18.1...v2.19.0
[2.18.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.18.0...v2.18.1
[2.18.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.17.0...v2.18.0
[2.17.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.16.0...v2.17.0
[2.16.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.15.2...v2.16.0
[2.15.2]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.15.1...v2.15.2
[2.15.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.15.0...v2.15.1
[2.15.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.14.0...v2.15.0
[2.14.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.13.0...v2.14.0
[2.13.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.12.0...v2.13.0
[2.12.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.11.0...v2.12.0
[2.11.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.10.1...v2.11.0
[2.10.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.10.0...v2.10.1
[2.10.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.9.0...v2.10.0
[2.9.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.8.1...v2.9.0
[2.8.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.8.0...v2.8.1
[2.8.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.7.1...v2.8.0
[2.7.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.7.0...v2.7.1
[2.7.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.6.1...v2.7.0
[2.6.1]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.6.0...v2.6.1
[2.6.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.5.0...v2.6.0
[2.5.0]: https://github.com/giantswarm/cluster-api-provider-aws-app/compare/v2.4.0...v2.5.0
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
