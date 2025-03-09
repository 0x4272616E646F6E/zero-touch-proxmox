terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }

  required_version = ">= 1.9.0"
}

provider "proxmox" {
  pm_api_url          = var.proxmox_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = false
}

locals {
  vm_name          = "talos-1.9" # string
  pve_node         = "pve"       # string
  iso_storage_pool = "local-pve" # string
}

resource "proxmox_cloud_init_disk" "ci" {
  name     = local.vm_name          # string
  pve_node = local.pve_node         # string
  storage  = local.iso_storage_pool # string

  meta_data = yamlencode({
    instance_id    = sha1(local.vm_name) # string
    local-hostname = local.vm_name       # string
  })

  user_data = <<-EOT
  #cloud-config
  users:
    - name: ${var.cloud_init_username}
      lock_passwd: false
      passwd: ${var.cloud_init_password}
  ssh_authorized_keys:
    - ${var.cloud_init_sshkey}
  EOT

  network_config = yamlencode({
    version = 1 # integer
    config = [{
      type = "physical" # string
      name = "eth0"     # string
      subnets = [{
        type    = "static"           # string
        address = "192.168.1.100/24" # string
        gateway = "192.168.1.1"      # string
        dns_nameservers = [
          "10.0.0.1" # string
        ]
      }]
    }]
  })
}

resource "proxmox_vm_qemu" "talos-1.9" {
  name                        = "talos-1.9"                 # string
  target_node                 = "pve"                       # string
  vmid                        = 100                         # integer
  desc                        = "Talos 1.9"                 # string
  define_connection_info      = true                        # bool
  bios                        = "seabios"                   # string
  onboot                      = true                        # bool
  startup                     = ""                          # string
  vm_state                    = ""                          # string
  oncreate                    = true                        # bool
  protection                  = false                       # bool
  tablet                      = false                       # bool
  boot                        = ""                          # string
  bootdisk                    = "scsi0"                     # string
  agent                       = 1                           # integer
  pxe                         = false                       # bool
  clone                       = "talos-1.9-template"        # string
  clone_id                    = 101                         # integer
  full_clone                  = true                        # bool
  hastate                     = ""                          # string
  hagroup                     = ""                          # string
  qemu_os                     = ""                          # string
  memory                      = 16384                       # integer
  balloon                     = 0                           # integer
  sockets                     = 1                           # integer
  cores                       = 8                           # integer
  vcpus                       = 1                           # integer
  cpu_type                    = "host"                      # string
  numa                        = false                       # bool
  hotplug                     = ""                          # string
  scsihw                      = ""                          # string
  pool                        = ""                          # string
  tags                        = ""                          # string
  force_create                = false                       # bool
  os_type                     = "l26"                       # string
  force_recreate_on_change_of = ""                          # string
  os_network_config           = ""                          # string
  ssh_forward_ip              = ""                          # string
  ssh_user                    = ""                          # string
  ssh_private_key             = ""                          # string
  ci_wait                     = 1                           # integer
  ciuser                      = var.cloud_init_username     # string
  cipassword                  = var.cloud_init_password     # string
  cicustom                    = ""                          # string
  ciupgrade                   = false                       # bool
  searchdomain                = var.cloud_init_searchdomain # string
  nameserver                  = var.cloud_init_nameserver   # string
  sshkeys                     = var.cloud_init_sshkey       # string
  ipconfig0                   = var.cloud_init_ipconfig0    # string
  # ipconfig(1-15)              = ""                          # string
  automatic_reboot = false # bool
  skip_ipv4        = false # bool
  skip_ipv6        = false # bool
  agent_timeout    = 60    # integer
  vga {
    type   = "serial0" # string
    memory = 16        # integer
  }
  network {
    id        = "0"      # integer
    model     = "virtio" # string
    macaddr   = ""       # string
    bridge    = "vmbr0"  # string
    tag       = ""       # integer
    firewall  = false    # bool
    mtu       = 1        # integer
    rate      = 0        # integer
    queues    = 1        # integer
    link_down = false    # bool
  }
  disks {
    ide {
      ide2 {
        cdrom {
          iso = proxmox_cloud_init_disk.ci.id # string
        }
      }
    }
    scsi {
      scsi0 {
        asyncio              = false   # bool
        backup               = false   # bool
        cache                = ""      # string
        discard              = ""      # string
        disk_file            = ""      # string
        emulatessd           = false   # bool
        format               = "qcow2" # string
        id                   = "scsi0" # string
        iops_r_burst         = 0       # integer
        iops_r_burst_length  = 0       # integer
        iops_r_concurrent    = 0       # integer
        iops_wr_burst        = 0       # integer
        iops_wr_burst_length = 0       # integer
        iops_wr_concurrent   = 0       # integer
        iothread             = false   # bool
        iso                  = ""      # string
        linked_disk_id       = ""      # string
        mbps_r_burst         = 0       # integer
        mbps_r_concurrent    = 0       # integer
        mbps_wr_burst        = 0       # integer
        mbps_wr_concurrent   = 0       # integer
        passthrough          = false   # bool
        readonly             = false   # bool
        replicate            = false   # bool
        serial               = ""      # string
        size                 = "20G"   # string
        slot                 = ""      # string
        storage              = "zfs"   #
        type                 = "scsi"  #
        wwn                  = ""      # string
      }
    }

  }
  pcis {
    pci0 {
      mapping {
        mapping_id    = "mapping-id"    # string
        raw_id        = ""              # string
        pcie          = true            # bool
        primary_gpu   = true            # bool
        rombar        = true            # bool
        device_id     = "device-id"     # string
        vendor_id     = "vendor-id"     # string
        sub_device_id = "sub-device-id" # string
        sub_vendor_id = "sub-vendor-id" # string
      }
    }
  }
}