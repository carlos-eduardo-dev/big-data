terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.1"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.7.5"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

provider "rke" {}

resource "libvirt_volume" "vm_disk" {
  count          = var.vm_count
  name = format("${var.cluster_name}-vm-%03d", count.index + 1)
  base_volume_id = libvirt_volume.os_image.id
  size           = var.vm_disk_size
}

resource "libvirt_volume" "longhorn_disk" {
  count  = var.vm_count
  name = format("${var.cluster_name}-longhorn-%03d", count.index + 1)
  size   = var.longhorn_disk_size
  format = "qcow2"
}

resource "libvirt_volume" "os_image" {
  name   = "ubuntu-oracular-cloud"
  source = "${path.module}/images/${var.vm_image}"
  format = "qcow2"
}

data "template_file" "user_data" {
  count = var.vm_count
  template = file("${path.module}/cloudinit.yaml")
  vars = {
    ssh_public_key = file(var.ssh_public_key_path)
    hostname = format("${var.cluster_name}-%03d", count.index + 1)
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  count     = var.vm_count
  name = format("cloudinit-disk-%03d.iso", count.index + 1)
  user_data = data.template_file.user_data[count.index].rendered
}

resource "libvirt_domain" "nodes" {
  count      = var.vm_count
  qemu_agent = true
  name = format("${var.cluster_name}-%03d", count.index + 1)
  memory     = var.vm_memory
  vcpu       = var.vm_cpus

  cpu {
    mode = "host-passthrough"
  }

  disk {
    volume_id = libvirt_volume.vm_disk[count.index].id
    scsi      = true
  }

  disk {
    volume_id = libvirt_volume.longhorn_disk[count.index].id
    scsi      = true
  }

  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  console {
    type        = "pty"
    target_port = "0"
  }

  graphics {
    type = "spice"
  }

  boot_device {
    dev = ["hd"]
  }
}

resource "null_resource" "wait_cloudinit" {
  count = var.vm_count

  connection {
    type = "ssh"
    host = libvirt_domain.nodes[count.index].network_interface[0].addresses[0]
    user = "ubuntu"
    private_key = file(var.ssh_private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Esperando o cloud-init terminar...'",
      "cloud-init status --wait >/dev/null 2>&1",
      "echo 'Cloud-init finalizado!'"
    ]
  }

  depends_on = [
    libvirt_domain.nodes
  ]
}

resource "rke_cluster" "cluster" {
  depends_on = [null_resource.wait_cloudinit]
  cluster_name       = var.cluster_name
  enable_cri_dockerd = true
  addons_include = []

  ingress {
    provider = "none"
  }

  connection {
    user = "admin"
  }

  dynamic "nodes" {
    for_each = libvirt_domain.nodes
    content {
      hostname_override = format("${var.cluster_name}-%03d", nodes.key + 1)
      node_name = format("${var.cluster_name}-%03d", nodes.key + 1)
      user    = "ubuntu"
      address = nodes.value.network_interface[0].addresses[0]
      ssh_key = file(var.ssh_private_key_path)

      role = nodes.key == 0 ? ["controlplane", "etcd", "worker"] : ["worker"]
    }
  }

  services {
    etcd {
      backup_config {
        enabled = true
      }
    }
  }
}

resource "local_file" "kube_config" {
  file_permission = "600"
  content         = rke_cluster.cluster.kube_config_yaml
  filename = pathexpand(var.kube_config_path)
}
