# Technical Assessment Documentation

## Task 1: Version Control Integration

**Status**: Complete  
**Repository**: [GitHub - WeddyNkatha265/afyatrack-ke](https://github.com/WeddyNkatha265/afyatrack-ke)

### Approach
I implemented a structured Git workflow with meaningful commit messages following conventional commits. The repository was organized with a clear project structure separating application code, infrastructure, and configuration files. Each commit represented a logical unit of work, from initial setup to feature implementation.

### Challenges Faced
- **Project Structure**: Initially struggled with organizing files between the root directory and app subdirectory
- **Commit Granularity**: Balancing atomic commits with the need to set up multiple components
- **Remote Repository**: Configuring proper GitHub remote and ensuring all relevant files were included while excluding sensitive data

### Solutions
- Created comprehensive .gitignore for Node.js and Terraform
- Used descriptive commit messages like "feat: add hospital registration UI" and "docs: update project documentation"
- Maintained separate commits for application logic, Docker configuration, and documentation

---

## Task 2: Containerization with Docker
**Status**: Complete  
**Docker Hub**: [weddynkatha265/afyatrack-ke](https://hub.docker.com/r/weddynkatha265/afyatrack-ke)

### Approach
Implemented a multi-container environment using Docker Compose with the web application and PostgreSQL database. The Dockerfile was optimized with multi-stage build principles, using Alpine Linux for minimal image size and including health checks for reliability.

### Challenges Faced
- **Dockerfile Paths**: COPY commands failed due to incorrect build context paths
- **Database Connectivity**: Application starting before database was ready
- **Permission Issues**: Docker daemon access required user group configuration
- **Missing Dependencies**: Package.json location issues caused build failures

### Solutions
- Fixed Dockerfile context and COPY paths to properly reference the app directory
- Added health checks and dependency management in docker-compose.yml
- Configured proper volume mounts for database persistence
- Implemented connection retry logic in the application

```dockerfile
# Key implementation details:
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

## Task 3: Infrastructure as Code with Terraform
**Status**: Complete  
**Cloud Provider**: AWS

### Approach
Designed and implemented AWS infrastructure using Terraform, creating a complete environment including VPC, EC2 instances, security groups, and networking components. The infrastructure was modular and followed AWS best practices for security and availability.

### Challenges Faced
- **Cloud Provider Selection**: Initially planned for AWS but faced account issues, explored DigitalOcean alternative
- **Resource Dependencies**: Proper ordering of resource creation (VPC before subnets, etc.)
- **Security Configuration**: Implementing least-privilege security groups
- **Cost Optimization**: Selecting appropriate instance sizes for demo environment

### Solutions
- Implemented proper dependency management using Terraform's implicit and explicit dependencies
- Configured security groups to allow only necessary ports (22, 80, 443, 3000)
- Used t3.micro instances for cost efficiency and free tier eligibility
- Added user data script for automatic application deployment on instance launch

```hcl
# Key resources provisioned:
- AWS VPC with public subnets
- EC2 instance with Elastic IP
- Security groups for web access
- Internet gateway and route tables
```

---

## Task 4: CI/CD Pipeline with Cloud Integration

**Status**: Complete  
**Pipeline**: GitHub Actions

### Approach
Implemented a comprehensive GitHub Actions workflow that automated testing, building, and deployment. The pipeline included multiple stages with proper environment handling and integrated with Docker Hub for container registry.

### Challenges Faced
- **Secret Management**: Secure handling of Docker Hub credentials and cloud tokens
- **Image Tagging**: Docker Hub naming requirements (lowercase only)
- **Multi-stage Coordination**: Ensuring proper dependency between test, build, and deploy stages
- **Environment Configuration**: Managing different configurations for various environments

### Solutions
- Used GitHub Secrets for sensitive credentials
- Implemented lowercase conversion for Docker image names
- Created conditional execution based on branch and environment
- Added comprehensive logging and status reporting

```yaml
# Pipeline stages implemented:
1. Test: Application unit tests
2. Build: Docker image creation with timestamp tags
3. Push: Upload to Docker Hub registry
**Image Tagging Strategy**:
- `latest` - Most recent stable version
- `2024-01-15T10-30-45Z` - ISO timestamp build
- `effaaabda483390c...` - Git commit SHA
4. Deploy: Infrastructure provisioning
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

---

## Task 5: Site Reliability Engineering

**Status**: Complete

### Approach
Implemented a complete monitoring stack with Prometheus for metrics collection and Grafana for visualization. Configured alerting rules for critical application metrics and established basic incident response procedures.

### Challenges Faced
- **Metrics Identification**: Determining which application metrics were most valuable
- **Alert Thresholds**: Setting appropriate values for different environments
- **Dashboard Design**: Creating meaningful visualizations for hospital data
- **Resource Constraints**: Running monitoring stack within limited resources

### Solutions
- Focused on key metrics: HTTP response codes, error rates, response times
- Implemented multi-level alerting (warning, critical)
- Created dedicated dashboards for application and infrastructure metrics
- Used efficient data retention policies to manage storage

```yaml
# Key monitoring components:
- Prometheus for metrics collection
- Grafana for visualization
- Custom application metrics
- Infrastructure monitoring
- Alerting rules on Grafana UI for critical events 
```

---

## Bonus Task: Ansible Configuration Management

**Status**: Complete

### Approach
Created idempotent Ansible playbooks for automated server configuration, including user management, service installation, and application deployment. The playbooks followed infrastructure as code principles.

### Challenges Faced
- **Idempotency**: Ensuring playbooks could run multiple times safely
- **Service Dependencies**: Proper ordering of service installation and startup
- **Cross-platform Compatibility**: Ensuring compatibility with different Linux distributions
- **Secret Management**: Handling sensitive data in configuration files

### Solutions
- Used Ansible modules designed for idempotent operations
- Implemented proper service handlers and dependencies
- Tested on multiple distributions (Ubuntu, CentOS)
- Used Ansible Vault for sensitive data encryption

```yaml
# Configuration management areas:
- User and group management
- PostgreSQL installation and configuration
- Nginx web server setup
- Application deployment
- Security hardening
```

---

## Key Technical Decisions & Lessons Learned
- Leveraging open-source tools and managed infrastructure where possible to reduce operational over-heads, costs and time.

### Architecture Decisions
1. **Microservices Approach**: Separated web application and database for scalability
2. **Container-First Design**: Built everything with Docker from the beginning
3. **Infrastructure as Code**: All cloud resources defined in Terraform
4. **Automated Pipelines**: CI/CD for consistent deployments

### Security Implementation
- Non-root user execution in containers
- Least-privilege security groups
- Environment variables for sensitive data
- Regular dependency updates

### Reliability Features
- Health checks and readiness probes
- Database connection pooling
- Graceful shutdown handling
- Comprehensive error logging

### Challenges Overcome
1. **Docker Networking**: Resolved container communication issues
2. **Database Persistence**: Implemented proper volume management
3. **CI/CD Complexity**: Managed multi-stage pipeline dependencies
4. **Monitoring Integration**: Connected application metrics with infrastructure monitoring

### Success Metrics Achieved
- ✅ Application successfully containerized and running
- ✅ Database persistence working correctly
- ✅ CI/CD pipeline executing without errors
- ✅ Infrastructure fully defined as code
- ✅ Monitoring and alerting configured
- ✅ Automated deployments functioning

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