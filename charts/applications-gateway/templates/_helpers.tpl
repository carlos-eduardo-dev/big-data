{{/*
Retorna o nome padrão do gateway
*/}}
{{- define "gateway.name" -}}
{{- $name := .Release.Name -}}
{{- if hasSuffix $name "-gateway" -}}
  {{- $name -}}
{{- else -}}
  {{- printf "%s-gateway" $name -}}
{{- end -}}
{{- end -}}

{{/*
Retorna o nome padrão do VirtualService gateway para uso em outros charts
*/}}
{{- define "gateway.fullname" -}}
{{ .Release.Namespace }}/{{ include "gateway.name" . }}
{{- end }}