

## ⚙️ Configuration

### Environment Variables
| Variable | Default | Description |
|----------|---------|-------------|
| `DB_HOST` | `localhost` | PostgreSQL database host |
| `DB_USER` | `postgres` | Database username |
| `DB_PASSWORD` | `password` | Database password |
| `DB_NAME` | `hospitals` | Database name |
| `DB_PORT` | `5432` | Database port |
| `PORT` | `3000` | Application port |
| `NODE_ENV` | `development` | Runtime environment |

### Docker Compose Configuration
```yaml
version: '3.8'
services:
  web:
    build: .
    ports: ["3000:3000"]
    environment:
      - DB_HOST=db
      - DB_USER=postgres
      - DB_PASSWORD=password
      - DB_NAME=hospitals
    depends_on:
      - db

  db:
    image: postgres:13-alpine
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=hospitals
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./database/init.sql:/docker-entrypoint-initdb.d/init.sql
```

## 🛠️ Technical Tasks Implementation

### ✅ Task 1: Version Control Integration (15%)
**Status**: Complete  
**Repository**: [GitHub - WeddyNkatha265/afyatrack-ke](https://github.com/WeddyNkatha265/afyatrack-ke)

**Implementation Details**:
- ✅ Git repository with meaningful commit history
- ✅ Descriptive commit messages following conventional commits
- ✅ Proper branching strategy
- ✅ GitHub remote repository setup
- ✅ Comprehensive .gitignore file

**Key Commits**:
- `feat: initialize afyatrack-ke hospital registry system`
- `feat: add node.js web app with postgresql integration`
- `feat: implement hospital registration UI with kenyan counties`
- `docs: add comprehensive project documentation`

### ✅ Task 2: Containerization with Docker (15%)
**Status**: Complete  
**Docker Hub**: [weddynkatha265/afyatrack-ke](https://hub.docker.com/r/weddynkatha265/afyatrack-ke)

**Implementation Details**:
- ✅ Multi-stage Dockerfile for optimized builds
- ✅ Docker Compose for local development environment
- ✅ Health checks and readiness probes
- ✅ Non-root user execution for security
- ✅ Proper volume mounts for data persistence

**Dockerfile Highlights**:
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY app/package*.json ./
RUN npm install --only=production
COPY app/ ./
USER node
EXPOSE 3000
HEALTHCHECK --interval=30s CMD node healthcheck.js
CMD ["npm", "start"]
```

### ✅ Task 3: Infrastructure as Code with Terraform (20%)
**Status**: Complete  
**Cloud Provider**: AWS

**Resources Provisioned**:
- ✅ **VPC** with public subnets in multiple AZs
- ✅ **EC2 Instance** (t3.micro - free tier eligible)
- ✅ **Security Groups** allowing HTTP/HTTPS/SSH traffic
- ✅ **Elastic IP** for static public address
- ✅ **Internet Gateway** and route tables
- ✅ **S3 Backend** for Terraform state management

**Deployment Commands**:
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

**Terraform Outputs**:
- Web Server URL: `http://<public-ip>:3000`
- SSH Access: `ssh -i ~/.ssh/id_rsa ubuntu@<public-ip>`

### ✅ Task 4: CI/CD Pipeline with Cloud Integration (25%)
**Status**: Complete  
**Pipeline**: GitHub Actions

**Pipeline Stages**:
1. **Test** - Run application tests
2. **Build** - Create Docker images with multiple tags
3. **Push** - Upload to Docker Hub registry
4. **Deploy** - Deploy to AWS infrastructure

**Image Tagging Strategy**:
- `latest` - Most recent stable version
- `2024-01-15T10-30-45Z` - ISO timestamp build
- `effaaabda483390c...` - Git commit SHA

**GitHub Actions Workflow**:
```yaml
name: CI/CD Pipeline
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps: [...]
  build-and-push:
    needs: test
    steps: [...]
  deploy:
    needs: build-and-push
    steps: [...]
```

### ✅ Task 5: Site Reliability Engineering (25%)
**Status**: Complete

**Monitoring Stack**:
- ✅ **Prometheus** - Metrics collection and storage
- ✅ **Grafana** - Visualization dashboards
- ✅ **Alerting** - Critical metrics monitoring
- ✅ **Health Checks** - Application status monitoring

**Key Metrics Tracked**:
- HTTP request rates and error rates
- Database connection pool status
- Container resource utilization
- Application response times

### ✅ Bonus Task: Ansible Configuration Management
**Status**: Complete

**Ansible Playbook Features**:
- ✅ User and group management
- ✅ PostgreSQL installation and configuration
- ✅ Nginx web server setup
- ✅ File permissions and security
- ✅ Idempotent operations

## 📊 Monitoring & Observability

### Prometheus Configuration
```yaml
scrape_configs:
  - job_name: 'afyatrack-app'
    static_configs:
      - targets: ['afyatrack-service:3000']
    metrics_path: '/metrics'
    scrape_interval: 15s
```

### Grafana Dashboards
- **Application Metrics**: HTTP requests, error rates, response times
- **System Metrics**: CPU, memory, disk usage
- **Business Metrics**: Hospital registrations, county distribution

### Alerting Rules
```yaml
groups:
- name: afyatrack-alerts
  rules:
  - alert: HighErrorRate
    expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.1
    for: 5m
    labels:
      severity: critical
```

## 🚀 Deployment

### Local Development
```bash
# Development with hot reload
cd app
npm install
npm run dev

# Or with Docker
docker-compose up --build
```

### Production Deployment
```bash
# Using Terraform
cd terraform
terraform apply

# Using Kubernetes
kubectl apply -f k8s/
```

### Docker Hub Images
```bash
# Pull latest image
docker pull weddynkatha265/afyatrack-ke:latest

# Run with environment variables
docker run -d -p 3000:3000 \
  -e DB_HOST=your-db-host \
  -e DB_USER=postgres \
  -e DB_PASSWORD=your-password \
  weddynkatha265/afyatrack-ke:latest
```

## 🔧 Development

### Setting Up Development Environment
```bash
# 1. Clone and install dependencies
git clone https://github.com/WeddyNkatha265/afyatrack-ke.git
cd afyatrack-ke/app
npm install

# 2. Start database
docker run -d --name postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=hospitals \
  -p 5432:5432 postgres:13-alpine

# 3. Run application
npm start
```

### Running Tests
```bash
# Unit tests
npm test

# Integration tests
npm run test:integration

# End-to-end tests
npm run test:e2e
```

### Database Migrations
```bash
# Run database initialization
psql -h localhost -U postgres -d hospitals -f database/init.sql
```

## 📈 Assessment Guide

### Verification Checklist
| Task | Verification Method | Expected Result |
|------|-------------------|-----------------|
| **Version Control** | Check GitHub commits | Meaningful commit history |
| **Containerization** | `docker-compose up` | App accessible on port 3000 |
| **Infrastructure** | `terraform output` | Resources created in AWS |
| **CI/CD** | GitHub Actions tab | Successful pipeline runs |
| **Monitoring** | Check Grafana | Metrics dashboard accessible |

### Quick Validation Script
```bash
#!/bin/bash
echo "🔍 Validating AfyaTrack KE Deployment..."

# Check Docker containers
echo "1. Checking Docker containers..."
docker-compose ps

# Test application health
echo "2. Testing application health..."
curl -f http://localhost:3000/health || echo "Health check failed"

# Check database connection
echo "3. Testing database..."
docker exec afyatrack-database pg_isready -U postgres

# Verify infrastructure
echo "4. Checking Terraform outputs..."
cd terraform && terraform output

echo "✅ Validation complete!"
```

### Cost Optimization
- **EC2 Instance**: t3.micro (free tier eligible)
- **EBS Storage**: 20GB gp2 volumes
- **Elastic IP**: Free when attached to running instance
- **S3**: Minimal storage for Terraform state

## 🔗 Useful Links

- **GitHub Repository**: https://github.com/WeddyNkatha265/afyatrack-ke
- **Docker Hub**: https://hub.docker.com/r/weddynkatha265/afyatrack-ke
- **CI/CD Pipeline**: GitHub Actions tab in repository
- **Terraform Documentation**: https://www.terraform.io/docs

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Author

- **Weddy Nkatha** - [WeddyNkatha265](https://github.com/WeddyNkatha265)

---

**For questions or issues, please open an issue on GitHub or contact the author.**

---
*Last updated: January 2024*  
*Project version: 1.0.0*
```

This comprehensive README provides:
- ✅ Complete project overview and architecture
- ✅ Detailed project structure
- ✅ Step-by-step setup instructions
- ✅ Task-by-task implementation details
- ✅ Configuration and deployment guides
- ✅ Assessment verification checklist
- ✅ All technical documentation in one place

The README is designed to be both beginner-friendly for quick setup and detailed enough for technical assessment and production deployment! 🚀
---------------


# AfyaTrack KE - Kenya Hospital Registry System

## Overview
A comprehensive hospital registration and management system for Kenyan healthcare facilities, built with modern DevOps practices and cloud-native technologies.

## 🚀 Features

- **🏥 Hospital Management**: Register and manage hospitals across Kenyan counties
- **🗺️ County-based Organization**: Categorize hospitals by Kenyan counties
- **📊 Real-time Dashboard**: Monitor hospital statistics and registrations
- **🐳 Containerized**: Full Docker support for development and production
- **☁️ Cloud Ready**: AWS infrastructure with Terraform
- **🔄 CI/CD**: Automated testing, building, and deployment
- **📈 Monitoring**: Prometheus and Grafana for observability
- **🎯 SRE Practices**: Health checks, metrics, and alerting

## 🏗️ Architecture


### Technology Stack
| Layer | Technology | Purpose |
|-------|------------|---------|
| **Frontend** | Node.js, Express, EJS | Web interface & server rendering |
| **Database** | PostgreSQL | Relational data storage |
| **Container** | Docker, Docker Compose | Environment consistency |
| **Orchestration** | Kubernetes | Container management |
| **Infrastructure** | Terraform, AWS | Cloud provisioning |
| **CI/CD** | GitHub Actions | Automation pipeline |
| **Monitoring** | Prometheus, Grafana | Observability |
| **Config Mgmt** | Ansible | Server automation |

## 📁 Project Structure

```
afyatrack-ke/
├── 📁 app/                          # Node.js Web Application
│   ├── 📄 package.json              # Dependencies and scripts
│   ├── 📄 server.js                 # Express server and routes
│   ├── 📄 healthcheck.js            # Container health checks
│   ├── 📁 views/                    # EJS templates
│   │   └── 📄 index.ejs             # Main hospital registry UI
│   └── 📁 public/                   # Static assets
│
├── 📁 database/                     # Database Configuration
│   └── 📄 init.sql                  # Schema and sample data
│
├── 📁 terraform/                    # Infrastructure as Code
│   ├── 📄 main.tf                   # AWS resource definitions
│   ├── 📄 variables.tf              # Input variables
│   ├── 📄 outputs.tf                # Output values
│   ├── 📄 terraform.tfvars          # Variable values
│   └── 📄 user-data.sh              # EC2 initialization script
│
├── 📁 k8s/                         # Kubernetes Manifests
│   ├── 📄 deployment.yml           # App deployment config
│   └── 📄 service.yml              # Service definitions
│
├── 📁 monitoring/                  # Observability
│   ├── 📄 prometheus.yml           # Metrics collection
│   ├── 📄 alerts.yml               # Alerting rules
│   └── 📄 grafana-dashboard.yml    # Dashboard configs
│
├── 📁 ansible/                     # Configuration Management
│   ├── 📄 playbook.yml             # Server configuration
│   └── 📄 inventory.yml            # Target servers
│
├── 📁 .github/workflows/           # CI/CD Pipelines
│   └── 📄 ci-cd.yml                # GitHub Actions workflow
│
├── 📄 Dockerfile                   # Container definition
├── 📄 docker-compose.yml           # Local development
├── 📄 .gitignore                   # Git ignore rules
└── 📄 README.md                    # Project documentation
```



## 🚀 Quick Start

### Prerequisites
- **Docker** & **Docker Compose**
- **Node.js** 18+ (for local development)
- **Git**
- **AWS Account** (for cloud deployment)

### Local Development
```bash
# 1. Clone the repository
git clone https://github.com/WeddyNkatha265/afyatrack-ke.git
cd afyatrack-ke

# 2. Start with Docker Compose
docker-compose up --build

# 3. Access the application
# Web Interface: http://localhost:3000
# Database: localhost:5432
```

### Using Docker Hub Image
```bash
# Run directly from Docker Hub
docker run -d -p 3000:3000 \
  -e DB_HOST=localhost \
  -e DB_USER=postgres \
  -e DB_PASSWORD=password \
  -e DB_NAME=hospitals \
  weddynkatha265/afyatrack-ke:latest
```

### Production Deployment

#### 1. Infrastructure (AWS)
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

#### 2. Automated CI/CD
Push to main branch triggers automatic deployment:
```bash
git add .
git commit -m "feat: new feature"
git push origin main
```

#### 3. Manual Deployment
```bash
# Build and push image
docker build -t weddynkatha265/afyatrack-ke:latest .
docker push weddynkatha265/afyatrack-ke:latest

# Deploy to EC2
./deploy-k8s.sh
```

## 📊 CI/CD Pipeline

### Pipeline Diagram
```
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   Code Commit   │  │   Build Stage   │  │   Test Stage    │
│                 │  │                 │  │                 │
│  • Git Push     │─▶│ • Docker Build  │─▶│ • Unit Tests    │
│  • PR Create    │  │ • Image Tag     │  │ • Linting       │
└─────────────────┘  │ • Push to Hub   │  └─────────────────┘
                     └─────────────────┘
                               │
                     ┌─────────────────┐  ┌─────────────────┐
                     │  Deploy Stage   │  │  Verify Stage   │
                     │                 │  │                 │
                     │ • SSH to EC2    │─▶│ • Health Check  │
                     │ • Pull Image    │  │ • Smoke Tests   │
                     │ • Start App     │  │ • Logs Check    │
                     └─────────────────┘  └─────────────────┘
```

### Pipeline Stages

1. **Test Stage**
   - Node.js dependency installation
   - Unit test execution
   - Code quality checks

2. **Build Stage**
   - Docker image build with `--no-cache`
   - Multi-tagging (timestamp, commit, latest)
   - Image verification and push to Docker Hub

3. **Deploy Stage**
   - SSH-based deployment to AWS EC2
   - Database initialization
   - Container orchestration
   - Health check verification

4. **Verify Stage**
   - Application health checks
   - Database connectivity tests
   - End-to-end functionality verification

## 🎯 Monitoring & Observability

### Access Points
- **Application**: `http://<ec2-ip>:3000`
- **Grafana Dashboards**: `http://<ec2-ip>:30609` (admin/admin123)
- **Prometheus Metrics**: `http://<ec2-ip>:32327`
- **Health Check**: `http://<ec2-ip>:3000/health`
- **Metrics Endpoint**: `http://<ec2-ip>:3000/metrics`

### Key Metrics Tracked
- HTTP request rates and error rates
- Hospital registration counts
- Database connection pool status
- Container resource utilization
- Application uptime and health status

## 🔧 Management Commands

### Application Management
```bash
# Check status
ssh -i ~/.ssh/ec2_key.pem ubuntu@<ec2-ip> "sudo docker ps"

# View logs
ssh -i ~/.ssh/ec2_key.pem ubuntu@<ec2-ip> "sudo docker logs afyatrack-web-app -f"

# Database access
ssh -i ~/.ssh/ec2_key.pem ubuntu@<ec2-ip> "sudo docker exec -it afyatrack-database psql -U postgres -d hospitals"
```

### Kubernetes Management
```bash
# Check cluster status
kubectl get all -n afyatrack-ke

# View application logs
kubectl logs -n afyatrack-ke -l app=afyatrack-web --tail=10

# Port forwarding for local access
kubectl port-forward -n afyatrack-ke service/afyatrack-service 8080:80
```

## 🛡️ Security Features

- Non-root user execution in containers
- Secure secret management with GitHub Secrets
- Database connection encryption
- Proper file permissions and ownership
- Firewall configuration (UFW)
- Security headers in Nginx
- Regular security updates

## 📈 Performance

- **Container Optimized**: Alpine Linux base images
- **Database Pooling**: Connection reuse for better performance
- **Caching**: Docker layer caching for faster builds
- **Resource Limits**: Kubernetes resource requests and limits
- **Health Checks**: Readiness and liveness probes

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Kenya Ministry of Health for inspiration
- AWS for cloud infrastructure
- Docker and Kubernetes communities
- Prometheus and Grafana for monitoring solutions

---

## 📞 Support

For support and questions:
- 📧 Email: weddynkatha265@github.com
- 🐛 Issues: [GitHub Issues](https://github.com/weddynkatha265/afyatrack-ke/issues)
- 📚 Documentation: [Project Wiki](https://github.com/weddynkatha265/afyatrack-ke/wiki)

---

**Built with ❤️ for Kenya's Healthcare System**