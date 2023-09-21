#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

cd "helm/cluster-api-provider-aws/templates"

for file in *_ciliumnetworkpolicy_*.yaml; do
    data=$(cat "${file}")
    (
        echo '{{- if .Values.ciliumNetworkPolicy.enabled }}'
        echo "${data}"
        echo '{{- end }}'
    ) > "${file}"
done
