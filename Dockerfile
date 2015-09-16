FROM google/cloud-sdk:latest

WORKDIR /app

COPY authenticate_and_run.sh ./
