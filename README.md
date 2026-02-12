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
    ├── docker/           # Docker installation
    │   └── tasks/
    │       └── main.yml
    ├── caddy/            # Caddy web server
    │   └── tasks/
    │       └── main.yml
    ├── jq/               # JSON processor
    │   └── tasks/
    │       └── main.yml
    ├── tmux/             # Terminal multiplexer
    │   └── tasks/
    │       └── main.yml
    └── zsh/              # Zsh shell with Oh My Zsh
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
  -  Configure with: `aws configure`

#### 4. Rclone
- Cloud storage sync tool
- Installed via official script
- Configure with: `rclone config`

#### 5. Docker
- Docker CE, Docker CLI, containerd
- Docker Buildx and Compose plugins
- Starts and enables Docker service
- Adds your current user to docker group

#### 6. Caddy
- Modern web server with automatic HTTPS
- Installed via official repository
- Starts and enables Caddy service
- Default configuration in `/etc/caddy/Caddyfile`

#### 7. jq
- JSON processor and query tool
- Useful for parsing and manipulating JSON data
- Command-line JSON processor

#### 8. tmux
- Terminal multiplexer
- Allows multiple terminal sessions in one window
- Session persistence across disconnections

#### 9. zsh + Oh My Zsh
- Enhanced shell with improved features
- Oh My Zsh framework with themes and plugins
- Sets zsh as default shell for the user

### Install Specific Roles Only

To install only specific software, comment out unwanted roles in `deployment.yml`:

```yaml
roles:
  - utilities      # Basic system utilities
  - network-utils  # Network tools
  # - awscli       # Comment to skip AWS CLI
  # - rclone       # Comment to skip Rclone
  - docker         # Docker installation
  # - caddy        # Comment to skip Caddy
  # - jq           # Comment to skip jq
  # - tmux         # Comment to skip tmux
  # - zsh          # Comment to skip zsh
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

**For Caddy:**
- Caddy is immediately ready to use
- Default configuration serves a welcome page on port 80
- Configure your sites in `/etc/caddy/Caddyfile`

**For zsh:**
- You need to either:
  - Log out and log back in for shell change to take effect, OR
  - Run: `zsh`
- Oh My Zsh configuration is in `~/.zshrc`
- Customize themes and plugins in `~/.zshrc`

**For tmux:**
- Start a new session: `tmux`
- Detach: `Ctrl+b` then `d`
- Reattach: `tmux attach`

**For jq:**
- Process JSON: `echo '{"key":"value"}' | jq .`
- Process files: `jq . < file.json`

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

# jq
jq --version

# tmux
tmux -V

# zsh
zsh --version
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
     - caddy
     - jq
     - tmux
     - zsh
     - your-role-name  # Add here
   ```

## Troubleshooting

- If you get permission errors, make sure you have sudo privileges
- If Ansible is not found, install it using: `sudo apt install ansible -y`
- For Docker permission issues after installation, remember to log out and log back in
- To verify rclone installation: `rclone version`
- To verify AWS CLI installation: `aws --version`
- For network tools, you may need to use `sudo` for some commands like `tcpdump`
