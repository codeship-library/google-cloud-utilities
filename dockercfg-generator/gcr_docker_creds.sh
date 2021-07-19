#!/bin/bash

set -e

: ${GOOGLE_AUTH_JSON:?'Set the GOOGLE_AUTH_JSON environment variable'}
: ${GOOGLE_AUTH_EMAIL:?'Set the GOOGLE_AUTH_EMAIL environment variable'}
: ${GOOGLE_PROJECT_ID:?'Set the GOOGLE_PROJECT_ID environment variable'}

# Writing environment variable to Keyfile so it can be loaded later on
echo "Logging into Google GCR"
echo "${GOOGLE_AUTH_JSON}" > /keyconfig.json
gcloud auth activate-service-account "${GOOGLE_AUTH_EMAIL}" --key-file /keyconfig.json --project "${GOOGLE_PROJECT_ID}"

# Syncing credentials
echo "Syncing GCR credentials"
gcloud docker --verbosity=error -a

echo "Writing Docker creds to $1"
cat ~/.dockercfg > $1
