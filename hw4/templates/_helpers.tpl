{{/*
Expand the name of the chart.
*/}}
{{- define "hw4.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hw4.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hw4.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hw4.labels" -}}
training: block4
helm.sh/chart: {{ include "hw4.chart" . }}
{{- include "hw4.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hw4.selectorLabels" -}}
{{$template := toString (base .Template.Name)}}
{{- if contains "frontapp" $template }}
homework: frontapp
app.kubernetes.io/name: {{ include "hw4.name" . }}-frontapp
app.kubernetes.io/instance: {{ .Release.Name }}-frontapp
app.kubernetes.io/instance: {{ .Release.Name }}-frontapp
{{- end }}
{{- if contains "backapp" $template }}
homework: backapp
app.kubernetes.io/name: {{ include "hw4.name" . }}-backapp
app.kubernetes.io/instance: {{ .Release.Name }}-backapp
app.kubernetes.io/instance: {{ .Release.Name }}-backapp
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hw4.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "hw4.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
