#!/bin/bash

set -e

# Writing environment variable to Keyfile so it can be loaded later on
echo $GOOGLE_KEY > keyconfig.json
gcloud auth activate-service-account $GOOGLE_AUTH_EMAIL --key-file ./keyconfig.json --project $GOOGLE_PROJECT_NAME


BUCKET_NAME=gs://codeship-production-testbucket
UPLOAD_FILE_NAME=$BUCKET_NAME/datefile

# Set the default zone to use
gcloud config set compute/zone us-central1-a

# Remove an existing bucket if it exists
gsutil rb $BUCKET_NAME | true

# Creating a bucket on Google Cloud Storage
gsutil mb $BUCKET_NAME

# Create a file to upload to Google Cloud Storage
date > datefile
# Upload file to Google Cloud Storage
gsutil cp ./datefile $BUCKET_NAME

# Download file from Google Cloud Storage for diff
gsutil cp $UPLOAD_FILE_NAME ./datefile_downloaded

# Removing file from Google Cloud Storage
gsutil rm $UPLOAD_FILE_NAME

# Removing Bucket on Google Cloud Storage
gsutil rb $BUCKET_NAME

# Generating diff from local file and downloaded file
diff datefile datefile_downloaded

# TESTING INTERACTION WITH GOOGLE COMPUTE ENGINE

# Starting an Instance in Google Compute Engine
gcloud compute instances create testmachine

# Stopping an Instance in Google Compute Engine
gcloud compute instances delete testmachine -q
