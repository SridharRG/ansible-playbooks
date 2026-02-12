# Ansible Playbooks for Ubuntu VM Setup

This repository contains Ansible playbooks for setting up and configuring a fresh Ubuntu VM.

## Structure

```
ansible-playbooks/
├── deployment.yml          # Main playbook
├── ansible.cfg            # Ansible configuration
├── inventory              # Inventory file (localhost)
└── roles/
    └── docker/            # Docker installation role
        └── tasks/
            └── main.yml   # Docker installation tasks
```

## Prerequisites

1. **Install Ansible on your Ubuntu VM:**
   ```bash
   sudo apt update
   sudo apt install ansible -y
   ```

## Usage

### Install Docker

To install Docker on your Ubuntu VM, run:

```bash
ansible-playbook deployment.yml
```

This will:
- Update apt cache
- Install required dependencies
- Add Docker's official GPG key
- Add Docker repository
- Install Docker CE, Docker CLI, containerd, and Docker plugins
- Start and enable Docker service
- Add your current user to the docker group

### After Installation

After Docker is installed, you need to either:
- Log out and log back in for group changes to take effect, OR
- Run: `newgrp docker`

### Verify Installation

```bash
docker --version
docker compose version
```

## Adding More Roles

To add more installation roles:

1. Create a new role directory:
   ```bash
   mkdir -p roles/your-role-name/tasks
   ```

2. Create the tasks file:
   ```bash
   nano roles/your-role-name/tasks/main.yml
   ```

3. Add your tasks to the `main.yml` file

4. Update `deployment.yml` to include your new role:
   ```yaml
   roles:
     - docker
     - your-role-name
   ```

## Troubleshooting

- If you get permission errors, make sure you have sudo privileges
- If Ansible is not found, install it using: `sudo apt install ansible -y`
- For Docker permission issues after installation, remember to log out and log back in
