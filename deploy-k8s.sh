#!/bin/bash

echo "🚀 Deploying AfyaTrack KE to Kubernetes..."

# Start Minikube if not running
minikube status || minikube start --driver=docker --cpus=2 --memory=4096

# Enable ingress
minikube addons enable ingress

# Deploy application
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/postgresql.yaml
kubectl apply -f k8s/web-app.yaml

# Wait for database
echo "⏳ Waiting for database to be ready..."
kubectl wait --for=condition=ready pod -l app=postgresql -n afyatrack-ke --timeout=180s

# Deploy monitoring
kubectl apply -f monitoring/prometheus.yaml
kubectl apply -f monitoring/grafana.yaml
kubectl apply -f monitoring/grafana-dashboard.yaml

echo "✅ Deployment complete!"
echo ""
echo "🌐 Access URLs:"
echo "   Application:   $(minikube service afyatrack-service -n afyatrack-ke --url)"
echo "   Prometheus:    $(minikube service prometheus-service -n afyatrack-ke --url)"
echo "   Grafana:       $(minikube service grafana-service -n afyatrack-ke --url)"
echo ""
echo "🔍 Check status: kubectl get all -n afyatrack-ke"