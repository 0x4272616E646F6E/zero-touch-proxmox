Terraform
=========

This is an optional role that configures the proxmox host to allow terraform to interact with it. This role is not required for the proxmox playbook to work.

Requirements
------------

None

Role Variables
--------------

terraform_user: "terraform"
terraform_password: "password"
terraform_role: "terraform"

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

MIT

Author Information
------------------

0xBrandon
