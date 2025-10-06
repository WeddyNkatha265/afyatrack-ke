# 🏥 AfyaTrack KE – Kenya Hospital Registry System

> **A cloud-native, DevOps-enabled hospital registration and management platform for Kenya.**

---

## 📚 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)
- [CI/CD Pipeline](#cicd-pipeline)
- [Monitoring & Observability](#monitoring--observability)
- [Security](#security)
- [Performance](#performance)
- [Development Guide](#development-guide)
- [Deployment Guide](#deployment-guide)
- [Assessment Guide](#assessment-guide)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)
- [Support](#support)
- [Useful Links](#useful-links)

---

## 🧭 Overview

AfyaTrack KE is a full-stack hospital registry and management system built with modern DevOps, Kubernetes, cloud infrastructure (AWS), observability, and CI/CD automation for real-world deployment in Kenya's healthcare sector.

---

## 🚀 Features

- **🏥 Hospital Management** – Register and manage hospitals across Kenyan counties  
- **🗺️ County-based Organization**  
- **📊 Real-time Dashboard**  
- **🐳 Dockerized App**  
- **☁️ Cloud Ready (AWS + Terraform)**  
- **🔄 CI/CD (GitHub Actions)**  
- **📈 Monitoring (Prometheus + Grafana)**  
- **🎯 SRE Practices: Health checks, metrics, alerts**

---

## 🏗️ Architecture

### 🔧 Technology Stack

| Layer            | Tech Stack                       | Purpose                          |
|------------------|----------------------------------|----------------------------------|
| Frontend         | Node.js, Express, EJS            | Web interface & server rendering |
| Database         | PostgreSQL                       | Relational data storage          |
| Containerization | Docker, Docker Compose           | Local/Prod packaging             |
| Orchestration    | Kubernetes                       | Container scheduling             |
| IaC              | Terraform, AWS                   | Infrastructure provisioning      |
| CI/CD            | GitHub Actions                   | Automation                       |
| Monitoring       | Prometheus, Grafana              | Observability                    |
| Config Mgmt      | Ansible                          | Server setup automation          |

---

## 📁 Project Structure

```
afyatrack-ke/
├── app/                 # Node.js App (Express + EJS)
│   ├── views/           # EJS templates
│   ├── public/          # Static assets
│   └── server.js        # Entry point
├── database/            # PostgreSQL schema (init.sql)
├── terraform/           # AWS Infrastructure as Code
├── k8s/                 # Kubernetes manifests
├── monitoring/          # Prometheus + Grafana configs
├── ansible/             # Server automation
├── .github/workflows/   # GitHub Actions pipeline
├── Dockerfile           # Image definition
├── docker-compose.yml   # Dev container orchestration
└── README.md
```


---

## ⚡ Quick Start

### ✅ Prerequisites

- Docker + Docker Compose  
- Node.js v18+  
- Git  
- AWS Account (for production)

---

### 🧪 Local Development

```bash
git clone https://github.com/WeddyNkatha265/afyatrack-ke.git
cd afyatrack-ke
docker-compose up --build
```

* App UI: [http://localhost:3000](http://localhost:3000)
* DB: PostgreSQL on localhost:5432

---

### 🐳 Run from Docker Hub

```bash
docker pull weddynkatha265/afyatrack-ke:latest

docker run -d -p 3000:3000 \
  -e DB_HOST=localhost \
  -e DB_USER=postgres \
  -e DB_PASSWORD=password \
  -e DB_NAME=hospitals \
  weddynkatha265/afyatrack-ke:latest
```

---

## 🔁 CI/CD Pipeline

### 📊 Pipeline Flow

```
Commit → Build → Test → Push → Deploy → Verify
```

### 🔧 Pipeline Stages

| Stage      | Description                                   |
| ---------- | --------------------------------------------- |
| **Test**   | Lint, Unit tests                              |
| **Build**  | Docker build + push to Docker Hub             |
| **Deploy** | SSH into EC2, pull image, apply K8s manifests |
| **Verify** | Health checks, metrics, smoke tests           |

---

## 📡 Monitoring & Observability

### 🔍 Access Points

| Component        | URL                                      |
| ---------------- | ---------------------------------------- |
| App UI           | `http://<ec2-ip>:3000`                   |
| Grafana          | `http://<ec2-ip>:30609` (admin/admin123) |
| Prometheus       | `http://<ec2-ip>:32327`                  |
| Health Check     | `http://<ec2-ip>:3000/health`            |
| Metrics Endpoint | `http://<ec2-ip>:3000/metrics`           |

---

### 📈 Metrics Tracked

* HTTP request rate & error rate
* Container health & uptime
* Hospital registration trends
* DB connection usage
* CPU, memory, and disk utilization

---

## 🛡️ Security

* Containers run as non-root
* Secrets managed via GitHub Actions
* Encrypted database connections
* UFW firewall enabled
* Nginx security headers
* Regular security updates

---

## ⚙️ Performance

* Alpine Linux for lightweight containers
* Docker layer caching
* PostgreSQL connection pooling
* Kubernetes resource limits
* Liveness & readiness probes

---

## 👨‍💻 Development Guide

### 🚧 Set Up Dev Environment

```bash
git clone https://github.com/WeddyNkatha265/afyatrack-ke.git
cd afyatrack-ke/app
npm install

# Optional: Start DB manually
docker run -d --name postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=hospitals \
  -p 5432:5432 postgres:13-alpine

npm run dev
```

### 🧪 Run Tests

```bash
npm test              # Unit tests
npm run test:integration
npm run test:e2e
```

### 🔄 Database Migration

```bash
psql -h localhost -U postgres -d hospitals -f database/init.sql
```

---

## 🚀 Deployment Guide

### 🌐 Local Deployment

```bash
docker-compose up --build
```

### ☁️ AWS Production

```bash
cd terraform
terraform init
terraform apply
```

Then:

```bash
docker build -t weddynkatha265/afyatrack-ke:latest .
docker push weddynkatha265/afyatrack-ke:latest
./deploy-k8s.sh
```

---

## 📈 Assessment Guide

### 💰 Cost Optimization

* EC2 Instance: `t3.micro` (Free Tier)
* EBS: 20GB `gp2` volumes
* Elastic IP: Free if attached
* S3: Minimal storage for Terraform state

---

## 🤝 Contributing

```bash
# 1. Fork the repository
# 2. Create a feature branch
git checkout -b feature/amazing-feature

# 3. Make your changes
git commit -m "Add amazing feature"
git push origin feature/amazing-feature

# 4. Open a Pull Request
```

---

## 📄 License

This project is licensed under the **MIT License**.


---

## 🙏 Acknowledgments

* Kenya Ministry of Health
* AWS Cloud Services
* Docker & Kubernetes Community
* Prometheus & Grafana maintainers

---

## 📞 Support

* 📧 Email: [weddynkatha265@github.com](mailto:weddynkatha265@github.com)
* 🐞 Report Bugs: [GitHub Issues](https://github.com/weddynkatha265/afyatrack-ke/issues)
* 📘 Docs: [Project Wiki](https://github.com/weddynkatha265/afyatrack-ke/wiki)

---

## 🔗 Useful Links

* 🔗 GitHub: [AfyaTrack KE](https://github.com/WeddyNkatha265/afyatrack-ke)
* 🐳 Docker Hub: [AfyaTrack Image](https://hub.docker.com/r/weddynkatha265/afyatrack-ke)
* 🔄 CI/CD: GitHub Actions tab
* 🌍 Terraform Docs: [terraform.io/docs](https://www.terraform.io/docs)

---

## 👤 Author

* **Weddy Nkatha** – [GitHub Profile](https://github.com/WeddyNkatha265)

---

**Built with ❤️ for Kenya's healthcare infrastructure.**
*Last updated: October 2025 · Version: 1.0.0*
```