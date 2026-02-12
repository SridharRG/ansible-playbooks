# Ansible Playbooks for Ubuntu VM Setup

This repository contains Ansible playbooks for setting up and configuring a fresh Ubuntu VM.

## Structure

```
ansible-playbooks/
├── deployment.yml          # Main playbook
├── ansible.cfg            # Ansible configuration
├── inventory              # Inventory file (localhost)
└── roles/
    ├── docker/            # Docker installation role
    │   └── tasks/
    │       └── main.yml   # Docker installation tasks
    └── caddy/             # Caddy web server role
        └── tasks/
            └── main.yml   # Caddy installation tasks
```

## Prerequisites

1. **Install Ansible on your Ubuntu VM:**
   ```bash
   sudo apt update
   sudo apt install ansible -y
   ```

## Usage

### Install All Software

To install all configured software (Docker, Caddy, etc.) on your Ubuntu VM, run:

```bash
ansible-playbook deployment.yml
```

This will install:
- **Docker**: Container platform with Docker CE, CLI, containerd, and plugins
- **Caddy**: Modern web server with automatic HTTPS

### Install Specific Software Only

To install only specific software, comment out unwanted roles in `deployment.yml`:

```yaml
roles:
  - docker    # Comment this line to skip Docker
  # - caddy   # Uncomment to skip Caddy
```

### What Gets Installed

#### Docker
- Updates apt cache and installs dependencies
- Adds Docker's official GPG key
- Adds Docker repository
- Installs Docker CE, Docker CLI, containerd, and Docker plugins
- Starts and enables Docker service
- Adds your current user to the docker group

#### Caddy
- Installs required dependencies
- Adds Caddy's official GPG key and repository
- Installs Caddy web server
- Starts and enables Caddy service
- Default configuration in `/etc/caddy/Caddyfile`

### After Installation

**For Docker:**
You need to either:
- Log out and log back in for group changes to take effect, OR
- Run: `newgrp docker`

**For Caddy:**
- Caddy is immediately ready to use
- Default configuration serves a welcome page on port 80
- Configure your sites in `/etc/caddy/Caddyfile`

### Verify Installation

```bash
# Docker
docker --version
docker compose version

# Caddy
caddy version
sudo systemctl status caddy
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
- If Caddy doesn't start, check the configuration: `sudo caddy validate --config /etc/caddy/Caddyfile`
- To view Caddy logs: `sudo journalctl -u caddy --no-pager`