#!/bin/bash

echo "Deploying to Kubernetes!"

# Authorize GKE Cluster\
echo "Athorize GKE"
gcloud container clusters get-credentials my-cluster --region us-east1 --project gcp-practice-1-453919

# Create secret for TLS
echo "Create Secret"
kubectl create secret tls my-tls-secret --key ../private.key --cert ../certificate.crt

# Apply the YAML Files
echo "Applying YAML"
kubectl apply -f ../kubernetes