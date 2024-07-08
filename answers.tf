
storageClass:
  name: dynamic-storage
  isDefault: "true"
  reclaimPolicy: Delete
  volumeBindingMode: Immediate

  # Select the provisioner based on your cloud provider
  # AWS EBS: kubernetes.io/aws-ebs
  # GCP PD: kubernetes.io/gce-pd
  provisioner: kubernetes.io/aws-ebs
  # provisioner: kubernetes.io/gce-pd



apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: {{ .Values.storageClass.name }}-{{ .Release.Namespace }}
  annotations:
    storageclass.kubernetes.io/is-default-class: "{{ .Values.storageClass.isDefault }}"
provisioner: {{ .Values.storageClass.provisioner }}
parameters:
  {{- if eq .Values.storageClass.provisioner "kubernetes.io/aws-ebs" }}
  type: gp2
  fsType: ext4
  {{- end }}
  {{- if eq .Values.storageClass.provisioner "kubernetes.io/gce-pd" }}
  type: pd-ssd
  replication-type: none
  {{- end }}
reclaimPolicy: {{ .Values.storageClass.reclaimPolicy }}
volumeBindingMode: {{ .Values.storageClass.volumeBindingMode }}