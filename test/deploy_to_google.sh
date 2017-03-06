#!/bin/bash
set -e

date=$(date "+%Y-%m-%d_%H-%M")
cluster_name="codeship-gcloud-test-${date}"

codeship_google authenticate

echo "Starting a small cluster with a single instance"
gcloud config set compute/zone us-central1-a
gcloud container clusters create "${cluster_name}" \
  --num-nodes 1 \
  --machine-type g1-small

echo "Shutting everything down again"
gcloud container clusters delete "${cluster_name}" -q
