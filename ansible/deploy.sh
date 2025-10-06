#!/bin/bash

set -e

echo "🚀 Starting Ansible Configuration - Bonus Task"

# Validate required environment variables
if [ -z "$EC2_PUBLIC_IP" ]; then
    echo "❌ ERROR: EC2_PUBLIC_IP environment variable is required"
    echo "Usage: EC2_PUBLIC_IP=1.2.3.4 SSH_PUBLIC_KEY='ssh-ed25519 ...' ./deploy.sh"
    exit 1
fi

if [ -z "$SSH_PUBLIC_KEY" ]; then
    echo "❌ ERROR: SSH_PUBLIC_KEY environment variable is required"
    echo "Get your public key with: cat ~/.ssh/id_ed25519.pub"
    echo "Usage: EC2_PUBLIC_IP=1.2.3.4 SSH_PUBLIC_KEY='ssh-ed25519 ...' ./deploy.sh"
    exit 1
fi

echo "📋 Deployment Configuration:"
echo "EC2 Public IP: $EC2_PUBLIC_IP"
echo "SSH Public Key: $(echo $SSH_PUBLIC_KEY | cut -d' ' -f3 | head -c 20)..."
echo "SSH Private Key: ${SSH_PRIVATE_KEY_PATH:-~/.ssh/id_ed25519}"

# Test SSH connection
echo "🔐 Testing SSH connection..."
if ! ssh -i "${SSH_PRIVATE_KEY_PATH:-~/.ssh/id_ed25519}" -o ConnectTimeout=5 -o BatchMode=yes ubuntu@$EC2_PUBLIC_IP "echo '✅ SSH connection successful'"; then
    echo "❌ SSH connection failed"
    echo "Please ensure:"
    echo "1. EC2 instance is running"
    echo "2. Security group allows SSH (port 22)" 
    echo "3. You're using the correct SSH key"
    exit 1
fi

# Run Ansible playbook
echo "🔄 Running Ansible playbook..."
ansible-playbook -i inventory.yml playbook.yml

echo ""
echo "🎉 Bonus Task Configuration Complete!"
echo "======================================"
echo "✅ PostgreSQL installed and running"
echo "✅ Nginx installed and running" 
echo "✅ DevOps user configured with SSH access"
echo "✅ Config file copied to /opt with proper permissions"
echo ""
echo "📋 Verification Commands:"
echo "ssh -i ${SSH_PRIVATE_KEY_PATH:-~/.ssh/id_ed25519} devops@$EC2_PUBLIC_IP"
echo "ssh -i ${SSH_PRIVATE_KEY_PATH:-~/.ssh/id_ed25519} devops@$EC2_PUBLIC_IP 'ls -la /opt/config.txt'"
echo "ssh -i ${SSH_PRIVATE_KEY_PATH:-~/.ssh/id_ed25519} devops@$EC2_PUBLIC_IP 'sudo systemctl status postgresql'"
echo "ssh -i ${SSH_PRIVATE_KEY_PATH:-~/.ssh/id_ed25519} devops@$EC2_PUBLIC_IP 'sudo systemctl status nginx'"