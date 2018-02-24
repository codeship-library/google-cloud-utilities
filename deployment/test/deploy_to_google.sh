#!/bin/bash
set -e

date=$(date "+%Y%m%d%H%M")
cluster_name="codeship-gcloud-test-${date}"

codeship_google authenticate

# echo "Setting context if cluster exists"
# gcloud container clusters get-credentials $CLUSTER_NAME \
# --project $PROJECT_ID \
# --zone $DEFAULT_ZONE

echo "Starting a small cluster with a single instance, if no cluster exists"
gcloud config set compute/zone us-central1-a
gcloud container clusters create "${cluster_name}" \
  --num-nodes 1 \
  --machine-type g1-small

echo "Shutting everything down again"
gcloud container clusters delete "${cluster_name}" -q
