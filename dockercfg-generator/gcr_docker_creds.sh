#!/bin/bash

set -e

: ${GOOGLE_AUTH_JSON:?'Set the GOOGLE_AUTH_JSON environment variable'}
: ${GOOGLE_AUTH_EMAIL:?'Set the GOOGLE_AUTH_EMAIL environment variable'}
: ${GOOGLE_PROJECT_ID:?'Set the GOOGLE_PROJECT_ID environment variable'}
: ${GOOGLE_LOCATION:?'Set the GOOGLE_LOCATION environment variable'}

# Writing environment variable to Keyfile so it can be loaded later on
echo "Logging into Google GCR"
echo "${GOOGLE_AUTH_JSON}" > /keyconfig.json
gcloud auth activate-service-account "${GOOGLE_AUTH_EMAIL}" --key-file /keyconfig.json --project "${GOOGLE_PROJECT_ID}"

# Syncing credentials
echo "Syncing GCR credentials for gcr.io"
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://gcr.io
echo "Syncing GCR credentials for us.gcr.io"
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://us.gcr.io
echo "Syncing GCR credentials for eu.gcr.io"
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://eu.gcr.io
echo "Syncing GCR credentials for asia.gcr.io"
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://asia.gcr.io
echo "Syncing GCR credentials for pkg.dev"
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://"${GOOGLE_LOCATION}"-docker.pkg.dev

echo "Writing Docker creds to $1"
chmod 544 ~/.docker/config.json
cp ~/.docker/config.json $1
