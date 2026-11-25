#!/usr/bin/env bash

# We don't support ROSA (Red Hat OpenShift Service on AWS), so this script
# removes its CRDs, RBAC rules and webhooks from the downloaded upstream
# manifests before they are rewritten with kustomize.

set -o errexit
set -o nounset
set -o pipefail

YQ="${YQ:-$(realpath "$(dirname "$0")/../bin/yq")}"

ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
INPUT_FILE="$ROOT_DIR/config/helm/input/infrastructure-components.yaml"

"${YQ}" e -i '
  select((.kind == "CustomResourceDefinition" and .spec.names.kind == "ROSA*") | not)
  | (select(.kind == "ClusterRole" or .kind == "Role") | .rules[] | select(has("resources")) | .resources) |= map(select(test("^rosa") | not))
  | del(select(.kind == "ClusterRole" or .kind == "Role") | .rules[] | select(has("resources") and (.resources | length) == 0))
  | (select(.kind == "MutatingWebhookConfiguration" or .kind == "ValidatingWebhookConfiguration") | .webhooks) |= map(select([.rules[].resources[] | test("^rosa")] | any | not))
' "$INPUT_FILE"
