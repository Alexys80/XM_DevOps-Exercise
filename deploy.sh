#!/bin/sh

## Prepare k8s
k3d registry create registry.localhost --port 5000
k3d cluster create mycluster --servers 1 --agents 1 --registry-use k3d-registry.localhost:5000 --registry-config registries.yaml

## Docker build and push
docker build -t localhost:5000/api:latest .
docker push localhost:5000/api:latest

## TODO: Deploy k8s manifests
helm install --namespace myns --create-namespace api ./api

## Clean up
# k3d cluster delete mycluster
# k3d registry delete registry.localhost