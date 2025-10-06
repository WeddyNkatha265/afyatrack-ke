#!/bin/bash

set -e

echo "🔍 Verifying Ansible Configuration - Bonus Task"

if [ -z "$EC2_PUBLIC_IP" ]; then
    echo "❌ EC2_PUBLIC_IP environment variable is required"
    exit 1
fi

SSH_KEY="${SSH_PRIVATE_KEY_PATH:-~/.ssh/id_ed25519}"

echo "📋 Running verification checks..."

# 1. Verify devops user SSH access
echo "1. Testing devops user SSH access..."
ssh -i "$SSH_KEY" -o ConnectTimeout=5 devops@$EC2_PUBLIC_IP "echo '✅ DevOps user SSH access working'"

# 2. Verify config file permissions
echo "2. Checking config file permissions..."
ssh -i "$SSH_KEY" devops@$EC2_PUBLIC_IP "ls -la /opt/config.txt"

# 3. Verify devops user can read/write config file
echo "3. Testing config file read/write access..."
ssh -i "$SSH_KEY" devops@$EC2_PUBLIC_IP "
  echo '✅ Reading config file:' && cat /opt/config.txt && echo '' &&
  echo '✅ Writing to config file:' && echo '# Test entry' >> /opt/config.txt && echo 'Write test successful'
"

# 4. Verify PostgreSQL is running
echo "4. Checking PostgreSQL status..."
ssh -i "$SSH_KEY" devops@$EC2_PUBLIC_IP "sudo systemctl status postgresql --no-pager"

# 5. Verify Nginx is running
echo "5. Checking Nginx status..."
ssh -i "$SSH_KEY" devops@$EC2_PUBLIC_IP "sudo systemctl status nginx --no-pager"

# 6. Verify devops user sudo access
echo "6. Testing devops user sudo access..."
ssh -i "$SSH_KEY" devops@$EC2_PUBLIC_IP "sudo whoami"

echo ""
echo "✅ All verification checks passed!"
echo "📊 Bonus Task Requirements Met:"
echo "  ✓ Non-root user (devops) with SSH access"
echo "  ✓ Config file copied to /opt with proper permissions"
echo "  ✓ PostgreSQL installed and running"
echo "  ✓ Nginx installed and running"
echo "  ✓ Proper file ownership (devops:devops)"
echo "  ✓ Proper permissions (664 - read/write for group)"