# 🏥 AfyaTrack KE - Kenya Hospital Registry System

A complete hospital management system for Kenyan counties with full DevOps implementation. This project demonstrates modern development practices with Docker, Kubernetes, AWS infrastructure, and automated CI/CD pipelines.

## 📋 What is AfyaTrack KE?

AfyaTrack KE is a web application that helps register and manage hospitals across different counties in Kenya. It tracks hospital details, bed capacity, and facility types. The project showcases:

- **Web Application**: Node.js + Express + PostgreSQL
- **Containerization**: Docker and Docker Compose
- **Orchestration**: Kubernetes with Minikube
- **Infrastructure**: AWS with Terraform
- **CI/CD**: GitHub Actions
- **Monitoring**: Prometheus + Grafana

## 🚀 Quick Start - Run the Application

### Option 1: Using Docker Compose (Recommended for Beginners)

```bash
# 1. Clone the repository
git clone https://github.com/WeddyNkatha265/afyatrack-ke.git
cd afyatrack-ke

# 2. Start all services
docker-compose up --build

# 3. Access the application
# Open your browser and go to: http://localhost:3000 and DB: PostgreSQL on localhost:5432
```

### Option 2: Using Kubernetes with Minikube

```bash
# 1. Start Minikube cluster
minikube start

# 2. Deploy the application
./deploy-k8s.sh

# 3. Get the application URL
minikube service list -n afyatrack-ke

# You'll see output like:
# ┌──────────────┬────────────────────┬──────────────┬───────────────────────────┐
# │  NAMESPACE   │        NAME        │ TARGET PORT  │            URL            │
# ├──────────────┼────────────────────┼──────────────┼───────────────────────────┤
# │ afyatrack-ke │ afyatrack-service  │ 80           │ http://192.*.49.*:30269 │
# │ afyatrack-ke │ grafana-service    │ 3000         │ http://192.*.49.*:30609 │
# │ afyatrack-ke │ postgresql         │ No node port │                           │
# │ afyatrack-ke │ prometheus-service │ 8080         │ http://192.*.49.*:32327 │
# └──────────────┴────────────────────┴──────────────┴───────────────────────────┘

# 4. Access the application using the URL from above
```

### Option 3: Using Pre-built Docker Image

```bash
# Run directly from Docker Hub
docker run -d -p 3000:3000 \
  -e DB_HOST=localhost \
  -e DB_USER=postgres \
  -e DB_PASSWORD=password \
  -e DB_NAME=hospitals \
  weddynkatha265/afyatrack-ke:latest
```

## 📁 Project Structure

```
afyatrack-ke/
├── app/                    # Node.js web application
│   ├── package.json       # Dependencies and scripts
│   ├── server.js          # Main application file
│   ├── healthcheck.js     # Health check for containers
│   └── views/             # HTML templates
│       └── index.ejs      # Main web page
├── database/
│   └── init.sql           # Database setup with sample hospitals
├── terraform/             # AWS infrastructure code
│   ├── main.tf            # Defines AWS resources
│   ├── variables.tf       # Configuration variables
│   └── outputs.tf         # Output values after deployment
├── k8s/                   # Kubernetes configuration files
│   ├── deployment.yml     # How to run the application
│   └── service.yml        # How to access the application
├── monitoring/            # Monitoring setup
│   ├── prometheus.yml     # Metrics collection
│   └── grafana-dashboard.yml # Dashboards
├── ansible/               # Server automation
│   └── playbook.yml       # Server setup scripts
├── .github/workflows/     # Automated testing and deployment
│   └── ci-cd.yml          # GitHub Actions pipeline
├── docker-compose.yml     # Local development setup
├── Dockerfile             # How to build the container
├── deploy-k8s.sh          # Kubernetes deployment script
├── Documentation.md       # Technical Assessment Documentation
└── README.md              # This file
```
## 🔁 CI/CD Pipeline

### 📊 Pipeline Flow

```
Commit → Build → Test → Push → Deploy → Verify
```

## 🛠️ How to Set Up for Development

### Prerequisites

Make sure you have these installed:

- **Docker** and **Docker Compose**
- **Node.js** (version 18 or higher)
- **Git**
- **Minikube** (for Kubernetes testing)
- **kubectl** (Kubernetes command line tool)

### Step-by-Step Development Setup

#### 1. Get the Code

```bash
git clone https://github.com/WeddyNkatha265/afyatrack-ke.git
cd afyatrack-ke
```

#### 2. Set Up the Application

**Method A: With Docker (Easiest)**
```bash
# This starts everything: web app + database
docker-compose up --build

# Check if it's working
curl http://localhost:3000/health
```

**Method B: Local Development**
```bash
# Install dependencies
cd app
npm install

# Start the application
npm start

# In another terminal, start the database
docker run -d --name postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=hospitals \
  -p 5432:5432 postgres:13-alpine
```

#### 3. Access the Application

- **Main Application**: http://localhost:3000
- **Health Check**: http://localhost:3000/health
- **Database**: localhost:5432 (username: postgres, password: password)

## 🌐 Application Features

Once running, you can:

1. **View Registered Hospitals**: See all hospitals in the system
2. **Add New Hospitals**: Register new hospitals with:
   - Hospital name
   - County (Nairobi, Mombasa, Kisumu, etc.)
   - Facility type (Public, Private, Mission)
   - Number of beds
3. **Track Statistics**: View total hospitals, counties covered, and bed capacity

### Default Login/Passwords

- **Database**: postgres / password
- **Application**: No login required - direct access
- **Grafana** (if using Kubernetes): admin / admin

## 🐳 Docker Details

### Available Docker Images

The application is available on Docker Hub with these tags:

```bash
# Pull specific versions
docker pull weddynkatha265/afyatrack-ke:latest
docker pull weddynkatha265/afyatrack-ke:2024-01-15T10-30-45Z  # Timestamp version
```

### Build Your Own Image

```bash
# Build from source
docker build -t my-afyatrack-ke .

# Run your custom image
docker run -p 3000:3000 my-afyatrack-ke
```

## ☸️ Kubernetes Deployment

### Using Minikube (Local Kubernetes)

```bash
# 1. Start your local Kubernetes cluster
minikube start

# 2. Deploy everything
./deploy-k8s.sh

# 3. Check what's running
kubectl get pods -n afyatrack-ke

# 4. Get access URLs
minikube service list -n afyatrack-ke
```

### Expected Kubernetes Services

After deployment, you should see these services:

| Service | Purpose | Access URL |
|---------|---------|------------|
| `afyatrack-service` | Main application | http://192.*.49.*:30269 |
| `grafana-service` | Monitoring dashboard | http://192.*.49.*:30609 |
| `prometheus-service` | Metrics collection | http://192.*.49.*:32327 |
| `postgresql` | Database | Internal only |

### Accessing Kubernetes Services

```bash
# Open the main application in browser
minikube service afyatrack-service -n afyatrack-ke

# Open Grafana dashboard
minikube service grafana-service -n afyatrack-ke

# Check application logs
kubectl logs -n afyatrack-ke deployment/afyatrack-web
```

## ☁️ AWS Infrastructure

### Deploy to AWS

```bash
cd terraform

# Initialize Terraform
terraform init

# See what will be created
terraform plan

# Deploy to AWS
terraform apply

# Get the public IP address
terraform output public_ip
```

### What Gets Created in AWS

- **EC2 Instance**: Virtual server running the application
- **VPC**: Private network
- **Security Groups**: Firewall rules (allows HTTP/HTTPS/SSH)
- **Elastic IP**: Static public IP address
- **Internet Gateway**: Internet access

### Access Your AWS Deployment

After Terraform completes:

```bash
# Get the application URL
terraform output web_server_url

# SSH into the instance (if needed)
terraform output ssh_connection
```

## 🔄 CI/CD Pipeline

The project automatically:

1. **Tests** the application on every code change
2. **Builds** Docker images with multiple tags
3. **Pushes** images to Docker Hub
4. **Deploys** to infrastructure

### Manual Pipeline Trigger

Push changes to main branch or create a pull request to trigger the pipeline.

## 📊 Monitoring

### With Kubernetes

When using the Kubernetes deployment, monitoring is automatically set up:

- **Prometheus**: Collects metrics at http://192.*.49.*:32327
- **Grafana**: Dashboards at http://192.*.49.*:30609
  - Username: `admin`
  - Password: `admin123`

### Metrics Collected

- Application response times
- HTTP request rates
- Error rates
- Database connection status
- System resource usage

## 🔧 Configuration

### Environment Variables

You can customize the application with these environment variables:

```bash
DB_HOST=localhost           # Database server
DB_USER=postgres           # Database username  
DB_PASSWORD=password       # Database password
DB_NAME=hospitals          # Database name
PORT=3000                  # Application port
NODE_ENV=production        # Environment
```

### Database Configuration

The application uses PostgreSQL with this structure:

```sql
CREATE TABLE hospitals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    county VARCHAR(100) NOT NULL,
    facility_type VARCHAR(100) NOT NULL,
    beds INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

Sample data includes major Kenyan hospitals like Kenyatta National Hospital, Moi Teaching Hospital, and Coast General Hospital.

## 🚀 Deployment Summary

### For Quick Testing
```bash
docker-compose up --build
# Access at: http://localhost:3000
```

### For Full Kubernetes Experience
```bash
minikube start
./deploy-k8s.sh
minikube service list -n afyatrack-ke
# Use the URLs provided
```

### For Production AWS Deployment
```bash
cd terraform
terraform apply
# Use the output URL
weddy@weddy-HP-EliteBook-Revolve-810-G3:~/weddys/afyatrack-ke/terraform$ terraform output
instance_id = "i-065aa3aa72595f0d1"
security_group_id = "sg-0b78736af46223117"
ssh_connection = "ssh -i ~/Documents/awse2eproject.pem ubuntu@54.224.136.*"
web_server_public_ip = "54.224.136.*"
web_server_url = "http://54.224.136.*:3000"
weddy@weddy-HP-EliteBook-Revolve-810-G3:~/weddys/afyatrack-ke/terraform$ 
```

## 📞 Getting Help

If you encounter issues:

1. Check that all containers are running: `docker-compose ps`
2. View application logs: `docker-compose logs web`
3. Check Kubernetes pods: `kubectl get pods -n afyatrack-ke`
4. Verify database connection: `docker-compose exec db psql -U postgres -d hospitals`

## 👨‍💻 Author

**Weddy Nkatha**  
- GitHub: [WeddyNkatha265](https://github.com/WeddyNkatha265)  
- Docker Hub: [weddynkatha265](https://hub.docker.com/u/weddynkatha265)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

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

**Start with `docker-compose up --build` to see the application in action!** 🏥







