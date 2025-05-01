variable "cluster_name" {
  default = "big-data"
}

variable "vm_image" {
  default = "oracular-server-cloudimg-amd64.img"
}

variable "vm_count" {
  default = 1
}

variable "vm_memory" {
  default = 30 * 1024 // 12G
}

variable "vm_cpus" {
  default = 15
}

variable "vm_disk_size" {
  default = 40 * 1024 * 1024 * 1024 // 10G
}

variable "longhorn_disk_size" {
  default = 60 * 1024 * 1024 * 1024 // 40G
}

variable "ssh_private_key_path" {
  default = "~/.ssh/id_ed25519"
}

variable "ssh_public_key_path" {
  default = "~/.ssh/id_ed25519.pub"
}

variable "kube_config_path" {
  default = "~/.kube/rancher"
}