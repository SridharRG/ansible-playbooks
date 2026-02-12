# Ansible Playbooks for Ubuntu VM Setup

This repository contains Ansible playbooks for setting up and configuring a fresh Ubuntu VM.

## Structure

```
ansible-playbooks/
├── deployment.yml          # Main playbook
├── ansible.cfg            # Ansible configuration
├── inventory              # Inventory file (localhost)
├── run.sh                # Quick run script
└── roles/
    ├── utilities/         # Common system utilities
    │   └── tasks/
    │       └── main.yml
    ├── network-utils/     # Network utilities
    │   └── tasks/
    │       └── main.yml
    ├── awscli/           # AWS CLI
    │   └── tasks/
    │       └── main.yml
    ├── rclone/           # Rclone cloud storage tool
    │   └── tasks/
    │       └── main.yml
    └── docker/           # Docker installation
        └── tasks/
            └── main.yml
```

## Prerequisites

1. **Install Ansible on your Ubuntu VM:**
   ```bash
   sudo apt update
   sudo apt install ansible -y
   ```

## Usage

### Install All Software

To install all configured software on your Ubuntu VM, run:

```bash
./run.sh
```

or

```bash
ansible-playbook deployment.yml
```

This will install all roles in the following order:

#### 1. Utilities
- **System monitoring**: htop
- **Text editors**: vim, nano
- **Version control**: git
- **Download tools**: curl, wget
- **Utilities**: unzip, tree

#### 2. Network Utilities
- **net-tools**: ifconfig, netstat, route, etc.
- **dnsutils**: dig, nslookup, etc.
- **traceroute**: Network path tracing
- **tcpdump**: Packet analyzer

#### 3. AWS CLI
- AWS Command Line Interface
- Configure with: `aws configure`

#### 4. Rclone
- Cloud storage sync tool
- Installed via official script
- Configure with: `rclone config`

#### 5. Docker
- Docker CE, Docker CLI, containerd
- Docker Buildx and Compose plugins
- Starts and enables Docker service
- Adds your current user to docker group

### Install Specific Roles Only

To install only specific software, comment out unwanted roles in `deployment.yml`:

```yaml
roles:
  - utilities      # Basic system utilities
  - network-utils  # Network tools
  # - awscli       # Comment to skip AWS CLI
  # - rclone       # Comment to skip Rclone
  - docker         # Docker installation
```

### After Installation

**For Docker:**
You need to either:
- Log out and log back in for group changes to take effect, OR
- Run: `newgrp docker`

**For AWS CLI:**
- Configure credentials: `aws configure`

**For Rclone:**
- Configure remotes: `rclone config`

### Verify Installation

```bash
# Basic utilities
htop --version
git --version

# Network utilities
ifconfig
dig google.com

# AWS CLI
aws --version

# Rclone
rclone version

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
     - utilities
     - network-utils
     - awscli
     - rclone
     - docker
     - your-role-name  # Add here
   ```

## Troubleshooting

- If you get permission errors, make sure you have sudo privileges
- If Ansible is not found, install it using: `sudo apt install ansible -y`
- For Docker permission issues after installation, remember to log out and log back in
- To verify rclone installation: `rclone version`
- To verify AWS CLI installation: `aws --version`
- For network tools, you may need to use `sudo` for some commands like `tcpdump`
