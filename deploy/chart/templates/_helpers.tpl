{{/* Define the template "application.name" if not defined already */}}
{{ define "application.name" -}}
{{ default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
