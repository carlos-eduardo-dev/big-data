output "vm_ips" {
  value = libvirt_domain.nodes[*].network_interface[0].addresses
}