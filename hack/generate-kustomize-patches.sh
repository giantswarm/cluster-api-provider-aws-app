#!/usr/bin/env bash

# This script will generate kustomize patches for webhooks by first getting the
# MutatingWebhookConfiguration and ValidatingWebhookConfiguration, so it
# generates patches only or those webhooks that are specified in upstream.
#
# This way we don't have to specify webhook patches manually, since those
# change from time to time, as CRDs are added, modified and removed.

set -o errexit
set -o nounset
set -o pipefail

YQ="${YQ:-$(realpath "$(dirname "$0")/../bin/yq")}"

# Directories
ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
KUSTOMIZE_DIR="$ROOT_DIR/config/helm"
HELM_DIR="$ROOT_DIR/helm/cluster-api-provider-aws"
KUSTOMIZE_INPUT_DIR="$ROOT_DIR/config/helm/input"

# Download upstream manifests
helm_values="$HELM_DIR/values.yaml"
org="giantswarm"
repo="cluster-api-provider-aws"
version="$("${YQ}" e -e '.tag' "$helm_values")" || { >&2 echo "Could not find image tag value"; exit 1; }
release_asset_filename="infrastructure-components.yaml"
url="https://github.com/$org/$repo/releases/download/$version/${release_asset_filename}"
mkdir -p "$KUSTOMIZE_INPUT_DIR"
curl -fsSL "$url" -o "$KUSTOMIZE_INPUT_DIR/${release_asset_filename}" || { >&2 echo "Failed to get release manifest from $url"; exit 1; }
