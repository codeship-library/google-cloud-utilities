FROM google/cloud-sdk:509.0.0-slim
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

RUN \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		git \
		openssh-client \
		sudo && \
	DEBIAN_FRONTEND=noninteractive sudo apt-get install -y --no-install-recommends \
		kubectl \
		google-cloud-sdk-gke-gcloud-auth-plugin && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

COPY scripts/ /usr/bin/
