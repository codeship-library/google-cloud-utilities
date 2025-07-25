FROM python:3.13-alpine
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

# Check for the latest version on
# https://cloud.google.com/sdk/docs/install#linux
ARG GOOGLE_CLOUD_VERSION="526.0.1"

ENV PATH="/google-cloud-sdk/bin:${PATH}"

RUN apk add --no-cache \
      bash \
      ca-certificates \
      openssl \
      docker \
    && wget "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_VERSION}-linux-x86_64.tar.gz" \
    && gunzip "google-cloud-sdk-${GOOGLE_CLOUD_VERSION}-linux-x86_64.tar.gz" \
    && tar xf "google-cloud-sdk-${GOOGLE_CLOUD_VERSION}-linux-x86_64.tar" \
    && rm -rf "google-cloud-sdk-${GOOGLE_CLOUD_VERSION}-linux-x86_64.tar" \
    && ./google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true \
    && gcloud config set --installation component_manager/disable_update_check true \
    && sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' /google-cloud-sdk/lib/googlecloudsdk/core/config.json \
    && mkdir /.ssh

COPY gcr_docker_creds.sh ./

ENTRYPOINT ["./gcr_docker_creds.sh"]
