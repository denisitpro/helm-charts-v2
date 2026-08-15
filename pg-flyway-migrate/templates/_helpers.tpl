{{/*
Return the full name of the resource.
*/}}
{{- define "pg-flyway-migrate.fullname" -}}
{{- if .Values.nameOverride }}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-migrate" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Return chart name.
*/}}
{{- define "pg-flyway-migrate.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end }}

{{/*
Return chart version.
*/}}
{{- define "pg-flyway-migrate.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pg-flyway-migrate.labels" -}}
app.kubernetes.io/name: {{ include "pg-flyway-migrate.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "pg-flyway-migrate.chart" . }}
{{- end }}
{{/*
Return the target namespace
*/}}
{{- define "common.names.namespace" -}}
{{- if .Values.namespaceOverride }}
{{- .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Namespace }}
{{- end }}
{{- end }}