FROM gcr.io/google_appengine/base

# This is loosely based on the Dockerfile for the google/cloud-sdk image available
# at https://hub.docker.com/r/google/cloud-sdk/~/dockerfile/

ENV \
	CACHE_BUST=1 \
	CLOUDSDK_PYTHON_SITEPACKAGES=1 \
	PATH="/google-cloud-sdk/bin:$PATH"

RUN \
  DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl \
    openjdk-7-jre-headless \
    openssh-client \
    php5-cgi \
    php5-cli \
    php5-mysql \
    python \
    python-openssl \
    unzip \
    wget && \
  curl -sSL https://get.docker.com/ | sh && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*

RUN \
  mkdir -p "${HOME}/.ssh" && \
  wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && \
  unzip google-cloud-sdk.zip && \
  rm google-cloud-sdk.zip && \
  google-cloud-sdk/install.sh \
    --usage-reporting=true \
    --path-update=true \
    --bash-completion=true \
    --rc-path=/.bashrc \
    --disable-installation-options && \
  gcloud --quiet components update \
    alpha \
    app \
    beta \
    kubectl \
    pkg-go \
    pkg-java \
    pkg-python \
    preview && \
  gcloud --quiet config set component_manager/disable_update_check true

COPY scripts/ /usr/bin/
