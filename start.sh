#!/bin/bash

set -e


# Start minikube
echo "Iniciando minikube..."
minikube start

# Creating argocd namespace
echo "Creating argocd namespace..."
kubectl create namespace argocd || echo "The argocd namespace already exists."

# Installing ArgoCD
echo "Installing ArgoCD in the argocd namespace..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Waiting for ArgoCD pods to be ready
echo "Waiting for ArgoCD pods to be ready..."
kubectl wait --for=condition=available --timeout=120s deployment/argocd-server -n argocd

# Port-forwarding to access the UI
echo "Setting up port-forwarding on port 8080..."
kubectl port-forward svc/argocd-server -n argocd 8080:443
echo "Access the UI at http://localhost:8080"