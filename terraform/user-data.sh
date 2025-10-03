#!/bin/bash
# User data script for AfyaTrack KE deployment

# Update system
apt-get update
apt-get upgrade -y

# Install Docker
apt-get install -y docker.io

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Add ubuntu user to docker group (to run without sudo)
usermod -aG docker ubuntu

# Create application directory
mkdir -p /opt/afyatrack-ke
cd /opt/afyatrack-ke

# Pull and run the application
docker run -d \
  --name afyatrack-ke \
  --restart unless-stopped \
  -p 3000:3000 \
  -e DB_HOST=postgres \
  -e DB_USER=postgres \
  -e DB_PASSWORD=password \
  -e DB_NAME=hospitals \
  weddynkatha265/afyatrack-ke:latest

# Wait for application to start
echo "Waiting for application to start..."
sleep 30

# Create a simple health check script
cat > /opt/health-check.sh << 'EOF'
#!/bin/bash
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/health)
if [ "$response" = "200" ]; then
  echo "✅ Application is healthy"
else
  echo "❌ Application health check failed: HTTP $response"
fi
EOF

chmod +x /opt/health-check.sh

# Run health check
/opt/health-check.sh

# Display completion message
echo "🎉 AfyaTrack KE deployment completed!"
echo "🌐 Access your application at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):3000"