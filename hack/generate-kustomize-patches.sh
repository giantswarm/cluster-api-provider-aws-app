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
version="$(yq e -e '.tag' "$helm_values")" || { >&2 echo "Could not find image tag value"; exit 1; }
release_asset_filename="infrastructure-components.yaml"
url="https://github.com/$org/$repo/releases/download/$version/${release_asset_filename}"
mkdir -p "$KUSTOMIZE_INPUT_DIR"
curl -fsSL "$url" -o "$KUSTOMIZE_INPUT_DIR/${release_asset_filename}" || { >&2 echo "Failed to get release manifest from $url"; exit 1; }

# Update kustomize patches for webhooks. We do this for every CRD

watch_filter="$(yq e '.watchfilter' "$helm_values")"

# For every CRD, add webhook label selector
for webhook_kind_prefix in Mutating Validating; do
    output_path="${KUSTOMIZE_DIR}/webhook-$(echo "${webhook_kind_prefix}" | tr '[:upper:]' '[:lower:]')-watchfilter.yaml"
    echo "# Generated by 'generate-kustomize-patches.sh'. Do not edit." > "${output_path}"

    for webhook_cr_name in $(yq e -N "select(.kind==\"${webhook_kind_prefix}WebhookConfiguration\") | .metadata.name" "$KUSTOMIZE_INPUT_DIR/$release_asset_filename"); do
        webhook="$(
            webhook_cr_name="$webhook_cr_name" \
            yq e "select((.kind==\"${webhook_kind_prefix}WebhookConfiguration\") and .metadata.name==env(webhook_cr_name))" \
                "$KUSTOMIZE_INPUT_DIR/$release_asset_filename"
        )"

        webhook_api_version="$(echo "$webhook" | yq e ".apiVersion" -)"

        echo "Generating watch-filter patches for ${webhook_kind_prefix}WebhookConfiguration $webhook_cr_name"

        webhook_patch="apiVersion: $webhook_api_version
kind: ${webhook_kind_prefix}WebhookConfiguration
metadata:
  name: $webhook_cr_name
webhooks: null
"

        # Get all CRDs for this provider
        for webhook_name in $(webhook_cr_name="$webhook_cr_name" yq e "select((.kind==\"${webhook_kind_prefix}WebhookConfiguration\") and .metadata.name==env(webhook_cr_name)) | .webhooks[].name" "$KUSTOMIZE_INPUT_DIR/$release_asset_filename"); do
            object_selector_patch="$(
                webhook_name="$webhook_name" \
                watch_filter="$watch_filter" \
                yq e --null-input \
                    '.name = env(webhook_name) |
                    .objectSelector.matchLabels["cluster.x-k8s.io/watch-filter"] = env(watch_filter)'
                )"

            webhook_patch="$(
                echo "$webhook_patch" | \
                    object_selector_patch="$object_selector_patch" \
                    yq e '.webhooks += [env(object_selector_patch)]' -
            )"
        done

        # Write webhook patch to file
        echo "$webhook_patch" >> "${output_path}"
    done
done
