#!/bin/bash

echo "Building Containers!"
githash=$(git log -1 --format=%H)

registry_name="us-east1-docker.pkg.dev/gcp-practice-1-453919/my-containers"

docker build -t "$registry_name/frontend:$githash" ../frontend
docker build -t "$registry_name/backend:$githash" ../backend

docker push "$registry_name/frontend:$githash"
docker push "$registry_name/backend:$githash"