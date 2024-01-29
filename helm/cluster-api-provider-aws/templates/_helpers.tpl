# TEMPLATE-APP: This is set as a reasonable default, feel free to change.

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Bootstrap EKS labels
*/}}
{{- define "labels.eks.bootstrap" -}}
{{ include "labels.common" . }}
{{ include "labels.selector.eks.bootstrap" . }}
cluster.x-k8s.io/provider: bootstrap-eks
{{- end -}}

{{- define "labels.selector.eks.bootstrap" -}}
app.kubernetes.io/name: {{ include "resource.eksbootstrap.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Controlplane EKS labels
*/}}
{{- define "labels.eks.controlplane" -}}
{{ include "labels.common" . }}
{{ include "labels.selector.eks.controlplane" . }}
cluster.x-k8s.io/provider: control-plane-eks
{{- end -}}

{{- define "labels.selector.eks.controlplane" -}}
app.kubernetes.io/name: {{ include "resource.ekscontrolplane.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Infrastructure labels
*/}}
{{- define "labels.infrastructure" -}}
{{ include "labels.common" . }}
{{ include "labels.selector.infrastructure" . }}
cluster.x-k8s.io/provider: infrastructure-aws
{{- end -}}

{{- define "labels.selector.infrastructure" -}}
app.kubernetes.io/name: {{ include "resource.default.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
giantswarm.io/service-type: {{ .Values.serviceType }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
{{- end -}}

{{- define "capa.crdInstall" -}}
{{- printf "%s-%s" ( include "name" . ) "crd-install" | replace "+" "_" | trimSuffix "-" -}}
{{- end -}}

{{- define "capa.CRDInstallAnnotations" -}}
"helm.sh/hook": "pre-install,pre-upgrade"
"helm.sh/hook-delete-policy": "before-hook-creation,hook-succeeded"
{{- end -}}

{{- define "capa.selectorLabels" -}}
app.kubernetes.io/name: "{{ template "name" . }}"
app.kubernetes.io/instance: "{{ template "name" . }}"
{{- end -}}

{{/* Create a label which can be used to select any orphaned crd-install hook resources */}}
{{- define "capa.CRDInstallSelector" -}}
{{- printf "%s" "crd-install-hook" -}}
{{- end -}}
