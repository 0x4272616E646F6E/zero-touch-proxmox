Security
=========

This role enhances the security posture of Proxmox hosts through various configurations and hardening measures.

Requirements
------------

- Ansible 2.9 or higher
- Root or sudo access to the Proxmox host

Role Variables
--------------

```yaml
# SSH configuration
security_ssh_port: 22                      # SSH port
security_permit_root_login: "no"           # Disable root SSH login
security_password_authentication: "no"      # Disable password authentication

# Firewall configuration
security_enable_firewall: true             # Enable built-in firewall
security_allowed_tcp_ports: [22, 8006]     # Default allowed TCP ports (SSH and Proxmox web UI)
security_allowed_ip_ranges: []             # Restrict access to specific IP ranges

# System hardening
security_kernel_hardening: true            # Apply kernel hardening parameters
security_remove_unused_packages: true      # Remove unnecessary packages
security_disable_unused_services: true     # Disable unneeded services

# Update management
security_enable_automatic_updates: false   # Enable unattended security updates
```

Dependencies
------------

None.

Example Playbook
----------------

Basic usage:

```yaml
- hosts: proxmox_hosts
  roles:
    - role: security
```

With custom settings:

```yaml
- hosts: proxmox_hosts
  roles:
    - role: security
      vars:
        security_ssh_port: 2222
        security_allowed_tcp_ports: [2222, 8006, 111]
        security_allowed_ip_ranges: ['192.168.1.0/24', '10.10.10.0/24']
        security_enable_automatic_updates: true
```

License
-------

MIT

# Author

0xBrandon
