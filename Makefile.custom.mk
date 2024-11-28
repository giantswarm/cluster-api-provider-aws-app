# Generate kustomize patches and all helm charts

OS ?= $(shell go env GOOS 2>/dev/null || echo linux)
ARCH ?= $(shell go env GOARCH 2>/dev/null || echo amd64)
YQ_BIN_VERSION := 4.44.5
YQ_BIN := ./bin/yq

$(YQ_BIN): ## Download yq locally if necessary.
	mkdir -p $(dir $@)
	curl -sfL https://github.com/mikefarah/yq/releases/download/v$(YQ_BIN_VERSION)/yq_$(OS)_$(ARCH) -o $@
	chmod +x $@

.PHONY: clean
clean:
	rm -f $(YQ_BIN)

.PHONY: generate
generate: $(YQ_BIN)
	./hack/generate-kustomize-patches.sh
	$(MAKE) delete-generated-helm-charts
	kustomize build config/helm -o helm/cluster-api-provider-aws/templates
	./hack/move-generated-crds.sh
	./hack/generate-crd-version-patches.sh
	./hack/wrap-with-conditional.sh

delete-generated-helm-charts:
	@rm -rf ./helm/cluster-api-provider-aws/templates/*.yaml
	@cp helm/cluster-api-provider-aws/files/copy/* helm/cluster-api-provider-aws/templates/

CRD_BUILD_DIR := out

$(CRD_BUILD_DIR):
	mkdir -p $(CRD_BUILD_DIR)/

.PHONY: release-manifests
release-manifests: $(CRD_BUILD_DIR) ## Builds the manifests to publish with a release
	# Build core-components.
	kustomize build helm/cluster-api-provider-aws/files > $(CRD_BUILD_DIR)/crds.yaml

.PHONY: verify
verify: generate
	@if !(git diff --quiet HEAD); then \
		git diff; \
		echo "generated files are out of date, run make generate"; exit 1; \
	fi
