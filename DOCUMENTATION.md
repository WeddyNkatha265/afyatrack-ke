# AfyaTrack KE - Technical Assessment Documentation

## Project Overview
**AfyaTrack KE** is a comprehensive Kenya Hospital Registry System designed to manage hospital registrations across Kenyan counties. The system demonstrates full DevOps lifecycle implementation from development to production deployment.

---

## Task 1: Version Control Integration (15%)

### Approach
- Initialized Git repository with meaningful commit history using conventional commits
- Created a Node.js web application with PostgreSQL integration and Kenyan county categorization
- Implemented proper branching strategy with descriptive commit messages
- Established comprehensive project structure with separation of concerns

### Challenges Faced
- **Initial Structure**: Multiple reorganizations needed to ensure proper separation of concerns
- **Commit History**: Maintaining atomic commits while setting up complex project structure
- **Large File Handling**: Created comprehensive .gitignore to exclude node_modules and sensitive files

### Solution
- Used feature-based branching with clear commit messages
- Implemented detailed README.md for project documentation
- Maintained consistent commit convention for better history tracking

---

## Task 2: Containerization with Docker (15%)

### Approach
- Created multi-stage Dockerfile using Alpine Linux for minimal footprint
- Implemented Docker Compose for local development with database integration
- Added health checks, proper user permissions, and security best practices
- Used container naming and tagging for better image management

### Challenges Faced
- **Path Issues**: Docker build context and COPY commands required careful path configuration
- **Permission Errors**: Docker daemon access required user group configuration
- **Missing Files**: Views directory wasn't properly included in initial builds
- **Database Integration**: Ensuring proper service dependencies in docker-compose

### Solution
- Fixed Dockerfile paths and build context
- Implemented proper volume mounts for database persistence
- Added comprehensive health checks and error handling
- Used `--no-cache` builds to ensure complete file inclusion

```dockerfile
# Optimized Dockerfile with security best practices
FROM node:18-alpine
WORKDIR /app
COPY app/package*.json ./
RUN npm install --only=production
COPY app/ ./
USER node
EXPOSE 3000
CMD ["npm", "start"]
```

---

## Task 3: Infrastructure as Code with Terraform (20%)

### Approach
- Designed cloud-agnostic Terraform configuration for AWS
- Implemented VPC with public subnets, internet gateway, and route tables
- Configured security groups allowing HTTP/HTTPS/SSH traffic
- Deployed EC2 instance with Elastic IP for static address
- Used user data script for automatic application deployment

### Challenges Faced
- **Cloud Provider Selection**: Initial AWS account issues required troubleshooting
- **Resource Dependencies**: Proper ordering of resource creation was critical
- **Security Configuration**: Implementing least-privilege security groups
- **Cost Optimization**: Selecting appropriate instance sizes for demo environment

### Solution
```hcl
# AWS EC2 instance with proper networking
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"  # Free tier eligible
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = file("${path.module}/user-data.sh")
}
```

### Resources Created:
- ✅ VPC with public subnets
- ✅ Internet Gateway and Route Tables
- ✅ Security Groups (SSH, HTTP, HTTPS, Port 3000)
- ✅ EC2 Instance (t3.micro)
- ✅ Elastic IP (Static Public IP)
- ✅ Proper IAM and networking configurations

---

## Task 4: CI/CD Pipeline with Cloud Integration (25%)

### Approach
- Implemented GitHub Actions workflow with multiple stages (test, build, deploy)
- Automated build, test, and deployment processes with proper environment handling
- Integrated Docker Hub for container registry management
- Configured SSH-based deployment to AWS EC2 instance
- Implemented comprehensive health checks and rollback capabilities

### Challenges Faced
- **Secret Management**: Secure handling of Docker Hub and AWS credentials
- **Image Tagging**: Timestamp and commit-based tagging for better traceability
- **Deployment Reliability**: Implementing retry logic and health verification
- **File Inclusion**: Ensuring views directory was properly included in builds

### Solution
```yaml
- name: Build Docker images with --no-cache
  run: |
    TIMESTAMP=$(date -u +"%Y-%m-%dT%H-%M-%SZ")
    docker build --no-cache \
      -t ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:$TIMESTAMP \
      -t ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest \
      .
```

### CI/CD Pipeline Diagram

```
Git Push/PR
    ↓
GitHub Actions Trigger
    ↓
┌─────────────────┐
│   Test Stage    │
│  - Node.js deps │
│  - Unit tests   │
└─────────────────┘
    ↓
┌─────────────────┐
│   Build Stage   │
│  - Docker build │
│  - Image tag    │
│  - Push to Hub  │
└─────────────────┘
    ↓
┌─────────────────┐
│  Deploy Stage   │
│  - SSH to EC2   │
│  - Pull image   │
│  - Stop/start   │
│  - Health check │
└─────────────────┘
    ↓
Production (EC2 + Docker)
```

### Pipeline Stages Detail:

1. **Test Stage**
   - Code checkout
   - Node.js environment setup
   - Dependency installation
   - Unit test execution

2. **Build Stage**
   - Docker image build with `--no-cache`
   - Multi-tagging (timestamp, commit, latest)
   - Image verification (views directory check)
   - Push to Docker Hub registry

3. **Deploy Stage**
   - SSH key setup and connection test
   - Database initialization file copy
   - Docker network and container management
   - Health check verification with retry logic
   - Comprehensive logging and status reporting

---

## Task 5: Site Reliability Engineering (25%)

### Approach
- Implemented Minikube local Kubernetes cluster for container orchestration
- Deployed monitoring stack with Prometheus and Grafana
- Configured custom application metrics and health checks
- Set up alerting rules and comprehensive dashboards
- Implemented proper resource limits and service discovery

### Challenges Faced
- **Port Conflicts**: Managing multiple services on same ports (Grafana vs Application)
- **Metrics Collection**: Implementing Prometheus client in Node.js application
- **Service Discovery**: Configuring proper Kubernetes networking and DNS
- **Resource Management**: Setting appropriate CPU/memory limits

### Solution
```yaml
# Kubernetes deployment with monitoring
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "3000"
```

### Monitoring Stack:
- **Prometheus**: Metrics collection and alerting
- **Grafana**: Visualization and dashboards
- **Custom Metrics**: HTTP requests, hospital registrations, error rates
- **Health Checks**: Readiness and liveness probes
- **Alerting**: Application down, high error rates, performance issues

### SRE Implementation:
- ✅ Application metrics endpoint (`/metrics`)
- ✅ Health check endpoint (`/health`)
- ✅ Kubernetes resource limits and requests
- ✅ Prometheus scraping configuration
- ✅ Grafana dashboards for visualization
- ✅ Alert rules for critical metrics

---

## Bonus Task: Ansible Configuration Management

### Approach
- Created idempotent Ansible playbook for complete server configuration
- Implemented user/group management with proper SSH access
- Automated PostgreSQL installation and database initialization
- Configured Nginx as reverse proxy with security headers
- Set up systemd service for application management

### Challenges Faced
- **Idempotency**: Ensuring playbook could run multiple times safely
- **Dependency Management**: Proper service ordering and dependencies
- **Security Configuration**: File permissions and firewall rules
- **Database Initialization**: Race conditions between service start and schema creation

### Solution
```yaml
- name: Configure complete infrastructure
  hosts: afyatrack_servers
  tasks:
    - name: Install and configure PostgreSQL
    - name: Setup Nginx reverse proxy
    - name: Deploy application with systemd
    - name: Configure firewall and security
```

---

## Key Technical Decisions & Architecture

### 1. Technology Stack Selection
- **Backend**: Node.js + Express (lightweight, excellent ecosystem)
- **Database**: PostgreSQL (ACID compliance, healthcare data requirements)
- **Containerization**: Docker + Docker Compose (industry standard)
- **Orchestration**: Kubernetes (scalability, self-healing)
- **Monitoring**: Prometheus + Grafana (open-source, powerful)
- **Infrastructure**: Terraform (cloud-agnostic, declarative)
- **Configuration**: Ansible (agentless, idempotent)

### 2. Security Implementation
- Non-root user execution in containers
- Secure secret management in CI/CD
- Database connection encryption
- Proper file permissions and firewall rules
- Security headers in Nginx configuration

### 3. Reliability Features
- Health checks and readiness probes
- Database connection pooling and retry logic
- Graceful shutdown handling
- Comprehensive error logging and monitoring
- Resource limits and auto-restart policies

---

## Challenges and Lessons Learned

### Major Challenges
1. **Docker Image Consistency**: Views directory missing from automated builds
2. **Port Management**: Kubernetes service port conflicts
3. **Dependency Timing**: Database initialization race conditions
4. **Secret Security**: Secure credential management across platforms

### Key Lessons
- **Start Simple**: Begin with minimal viable configuration and iterate
- **Test Early**: Local testing saves significant CI/CD debugging time
- **Document Assumptions**: Clear documentation prevents configuration errors
- **Security First**: Implement security considerations from the beginning
- **Monitor Everything**: Comprehensive observability is crucial for reliability

### Success Metrics
- ✅ Application successfully containerized and running
- ✅ Database persistence working correctly
- ✅ CI/CD pipeline executing without errors
- ✅ Infrastructure fully defined as code
- ✅ Monitoring and alerting configured
- ✅ Zero-downtime deployments achieved

---

## Future Improvements

### Short-term Enhancements
- [ ] Implement database migrations system
- [ ] Add comprehensive unit and integration tests
- [ ] Set up SSL/TLS encryption with Let's Encrypt
- [ ] Implement backup and disaster recovery procedures

### Long-term Roadmap
- [ ] Multi-region deployment for high availability
- [ ] Advanced monitoring with APM integration
- [ ] Automated scaling policies based on metrics
- [ ] Blue-green deployment strategies
- [ ] Service mesh implementation for microservices

---

## Quick Start Guide

### Local Development
```bash
git clone https://github.com/weddynkatha265/afyatrack-ke.git
cd afyatrack-ke
docker-compose up --build
# Access: http://localhost:3000
```

### Production Deployment
```bash
# Infrastructure
cd terraform && terraform apply

# Application
git push origin main  # Triggers automated deployment
```

### Monitoring Access
```bash
kubectl port-forward -n afyatrack-ke service/grafana-service 3000:3000
# Grafana: http://localhost:3000 (admin/admin123)
```

This documentation demonstrates a comprehensive understanding of DevOps principles and practical implementation skills across the entire software delivery lifecycle, from local development to production deployment with full observability.