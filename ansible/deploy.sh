#!/bin/bash

set -e

echo "🚀 Starting Ansible Configuration Management for AfyaTrack KE"

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "❌ Ansible is not installed. Installing..."
    sudo apt update
    sudo apt install -y ansible
fi

# Check if hosts file is configured
if [ ! -f hosts ]; then
    echo "❌ hosts file not found. Creating template..."
    cat > hosts << EOF
[afyatrack_servers]
afyatrack-ec2 ansible_host=YOUR_EC2_IP_HERE ansible_user=ubuntu

[afyatrack_servers:vars]
ansible_ssh_private_key_file=~/.ssh/ec2_key.pem
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
    echo "⚠️  Please edit hosts file with your EC2 IP address"
    exit 1
fi

# Test connection
echo "🔍 Testing SSH connection to EC2 instance..."
ansible afyatrack_servers -m ping

# Run the playbook
echo "📦 Running Ansible playbook..."
if [ -f vault.yml ]; then
    ansible-playbook playbook.yml --ask-vault-pass
else
    ansible-playbook playbook.yml
fi

echo "✅ Ansible configuration completed successfully!"
echo ""
echo "🌐 Application should be accessible at: http://YOUR_EC2_IP"
echo "🔍 Check service status: ssh ubuntu@YOUR_EC2_IP 'systemctl status afyatrack-ke'"