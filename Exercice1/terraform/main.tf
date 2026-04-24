terraform {
  required_providers {
    multipass = {
      source  = "larstobi/multipass"
      version = "1.4.3"
    }
  }
}

provider "multipass" {}

resource "multipass_instance" "vm" {
  name = "nginx-vm"
  cpus = 2
  memory = "2GiB"
  disk = "10GiB"
  image = "noble"
  cloudinit_file = local_file.cloud_init.filename
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../ansible/hosts.tpl", {
    host_ip = multipass_instance.vm.ipv4
  })
  filename = "${path.module}/../ansible/hosts"
}

resource "local_file" "cloud_init" {
  content = templatefile("${path.module}/cloud-init.tpl", {
    ssh_public_key = var.ssh_public_key
  })
  filename = "${path.module}/cloud-init.yaml"
}