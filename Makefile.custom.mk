# Generate kustomize patches and all helm charts
.PHONY: generate
generate:
	./hack/generate-kustomize-patches.sh
	$(MAKE) delete-generated-helm-charts
	kustomize build config/helm -o helm/cluster-api-provider-aws/templates
	./hack/move-generated-crds.sh
	./hack/generate-crd-version-patches.sh

delete-generated-helm-charts:
	@mv ./helm/cluster-api-provider-aws/templates/ssh-sso-public-key-secret.yaml ./ssh-sso-public-key-secret.yaml
	@rm -rf ./helm/cluster-api-provider-aws/templates/*.yaml
	@cp helm/cluster-api-provider-aws/files/copy/* helm/cluster-api-provider-aws/templates/
	@mv ./ssh-sso-public-key-secret.yaml ./helm/cluster-api-provider-aws/templates/ssh-sso-public-key-secret.yaml

CRD_BUILD_DIR := out

$(CRD_BUILD_DIR):
	mkdir -p $(CRD_BUILD_DIR)/

.PHONY: release-manifests
release-manifests: $(CRD_BUILD_DIR) ## Builds the manifests to publish with a release
	# Build core-components.
	kustomize build helm/cluster-api-provider-aws/files > $(CRD_BUILD_DIR)/crds.yaml
