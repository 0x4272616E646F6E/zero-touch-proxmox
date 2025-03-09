# Zero-Touch Proxmox Deployment Container with Ansible and Terraform

This repository provides a minimal PXE boot server in a Docker container, along with the necessary configurations to deploy and configure a Proxmox node. It uses Ansible for configuration management and Terraform for infrastructure automation. This setup can be used to automate the installation of Proxmox VE and configure VMs, storage, and networking, with zero-touch deployment.

## Table of Contents

- [Zero-Touch Proxmox Deployment Container with Ansible and Terraform](#zero-touch-proxmox-deployment-container-with-ansible-and-terraform)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Requirements](#requirements)
  - [Repository Structure](#repository-structure)
  - [How to Build the Container](#how-to-build-the-container)
  - [How to Run the Container](#how-to-run-the-container)
  - [Configuration](#configuration)
  - [DNS and DHCP Server](#dns-and-dhcp-server)
  - [PXE Setup](#pxe-setup)
  - [API Setup](#api-setup)
  - [Ansible Setup](#ansible-setup)
  - [Terraform Setup](#terraform-setup)
  - [Contributing](#contributing)
  - [License](#license)

## Overview

Zero-Touch Proxmox is a solution for automating the deployment of Proxmox VE using a PXE Boot server inside a Docker container. It integrates Ansible for configuration management and Terraform for infrastructure automation, enabling easy and automated deployment of Proxmox on your infrastructure.

Features:
Serve Proxmox installation via PXE Boot.
Configure Proxmox node using Ansible playbooks.
Deploy Proxmox VM or container using Terraform.
Integrated with dnsmasq for DHCP and TFTP server.
Configured nginx for serving Proxmox files via HTTP.

## Requirements

Docker: To build and run the container.
PXE Boot Server: A basic PXE boot environment for network-based Proxmox installation.
Proxmox: A running Proxmox instance to deploy VMs and manage infrastructure.
API: A Flask API for post-installation callbacks.
Ansible: For configuration management.
Terraform: For infrastructure automation.

## Repository Structure

``` dir
``` dir
zero-touch-proxmox/
├── Dockerfile                # Dockerfile to build the container
├── ansible/
│   ├── playbooks/            # Ansible playbooks for configuration
│   │   ├── configure_proxmox.yml  # Configure the Proxmox node
│   │   └── deploy_proxmox_host.yml  # Deploy Proxmox VM using Terraform
│   └── inventory/            # Ansible inventory for Proxmox nodes
│       └── hosts.ini
├── terraform/
│   ├── main.tf               # Terraform configuration to deploy Proxmox VMs
│   └── variables.tf          # Terraform variables
├── tftp/                     # PXE boot files (e.g., bootloader)
│   └── ...
├── proxmox/                  # Proxmox installation files (e.g., ISO)
│   └── ...
├── api/                      # Flask API application
│   ├── app.py                # Main Flask application
│   ├── templates/            # Flask templates
│   ├── static/               # Static assets
│   └── config.py             # API configuration
├── scripts/
│   └── post_install.sh       # Post-installation callback script
├── nginx.conf                # Nginx configuration for serving Proxmox files
└── dnsmasq.conf    
```

## How to Build the Container

Clone this repository:

``` shell
git clone https://github.com/yourusername/zero-touch-proxmox.git
cd zero-touch-proxmox
Build the Docker image:
docker build -t zero-touch-proxmox .
How to Run the Container
```

## How to Run the Container

Run the container with the following command:

``` shell
docker run -d --name zero-touch-proxmox \
  --network host \
  -p 5000:5000 \
  -e API_KEY=your_secret_api_key \
  zero-touch-proxmox
```

This will start the container with:

- PXE, TFTP, HTTP services for installation
- Flask API on port 5000 for post-installation callbacks
- Ansible and Terraform for host configuration

You can secure the API with an API key that your post-installation scripts will use to authenticate.

## Configuration

## DNS and DHCP Server

This container expects an existing DNS and DHCP server in your environment. You’ll need to configure your DHCP server to point to the container for the PXE boot files.

## PXE Setup

The PXE server in the container is configured using dnsmasq and serves the necessary boot files for the Proxmox installation. Make sure that your network environment is set up to allow PXE booting from the container.

## API Setup

The container runs a Flask application that listens for POST requests from newly provisioned Proxmox hosts. After PXE installation completes, the host runs a callback script that sends its configuration details to this API:

- The API endpoint `/api/callback` receives host information
- Based on the received data, it triggers the appropriate Ansible playbooks
- The API then initiates Terraform for VM provisioning if required
- Status and logs are available through the API dashboard

You can access the API dashboard at `http://<host-ip>:5000/` to monitor installation progress and view system status.

## Ansible Setup

You can configure the Proxmox host and VM with Ansible by creating playbooks inside the container. The default configuration files are located in the ansible/ directory. You can modify these playbooks to suit your specific requirements.

## Terraform Setup

Terraform is configured to automate the creation of Proxmox VMs based on templates. The default Terraform configuration files are located in the terraform/ directory. You can modify these files to deploy Proxmox VMs or containers with your preferred specifications.

## Contributing

If you have suggestions or improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License – see the LICENSE file for details.
