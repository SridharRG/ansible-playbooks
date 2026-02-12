#!/bin/bash

# Simple wrapper script to run the deployment playbook

echo "Starting Ubuntu VM setup with Ansible..."
echo "========================================"

# Check if ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo "Ansible is not installed. Installing now..."
    sudo apt update
    sudo apt install ansible -y
fi

# Run the playbook
echo ""
echo "Running deployment playbook..."
ansible-playbook deployment.yml

echo ""
echo "========================================"
echo "Setup complete!"
echo ""
echo "IMPORTANT: If Docker was installed, you need to either:"
echo "  1. Log out and log back in, OR"
echo "  2. Run: newgrp docker"
echo ""
echo "Then verify with: docker --version"
