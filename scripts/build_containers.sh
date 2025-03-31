#!/bin/bash

echo "Building Containers!"

registry_name="us-east1-docker.pkg.dev/gcp-practice-1-453919/my-containers"

docker build -t "$registry_name/frontend" ../frontend
docker build -t "$registry_name/backend" ../backend

docker push "$registry_name/frontend"
docker push "$registry_name/backend"