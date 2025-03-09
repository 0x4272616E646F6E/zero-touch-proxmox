# Talos Role

This role automates the installation and configuration of Talos Linux on Proxmox hosts using Ansible.

## Requirements

- Ansible 2.9 or higher
- Proxmox VE 7.0 or higher
- `talosctl` command-line tool installed on the Ansible control node
- SSH access to the Proxmox hosts

## Role Variables

### Required Variables

| Variable | Description |
|----------|-------------|
| `talos_version` | Talos Linux version to install |
| `talos_cluster_name` | Name of the Kubernetes cluster |
| `talos_node_ips` | List of IP addresses for Talos nodes |
| `talos_control_plane_nodes` | List of control plane node details |
| `talos_worker_nodes` | List of worker node details |

### Optional Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `talos_api_endpoint` | API endpoint for the Talos cluster | First control plane node IP |
| `talos_network_config` | Network configuration for Talos nodes | {} |
| `talos_machine_disk` | Disk to install Talos on | "virtio0" |
| `talos_node_memory` | Memory allocation for nodes | 4096 |
| `talos_node_cpu` | CPU cores for nodes | 2 |

## Dependencies

None.

## Example Playbook

```yaml
- name: Deploy Talos Linux
  hosts: proxmox_hosts
  become: true
  vars:
    talos_version: "v1.4.5"
    talos_cluster_name: "my-k8s-cluster"
    talos_node_ips:
      - "192.168.1.100"
      - "192.168.1.101"
      - "192.168.1.102"
    talos_control_plane_nodes:
      - name: "control-plane-1"
        ip: "192.168.1.100"
    talos_worker_nodes:
      - name: "worker-1"
        ip: "192.168.1.101"
      - name: "worker-2"
        ip: "192.168.1.102"
  roles:
    - role: talos
```

## License

MIT

## Author Information

0xBrandon
