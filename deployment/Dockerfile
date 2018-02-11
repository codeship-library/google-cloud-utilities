FROM gcr.io/google_appengine/base
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

# This is loosely based on the Dockerfile for the google/cloud-sdk image available
# at https://hub.docker.com/r/google/cloud-sdk/~/dockerfile/

ENV CACHE_BUST='2018-02-11' \
		CLOUDSDK_PYTHON_SITEPACKAGES=1 \
		PATH="/google-cloud-sdk/bin:${PATH}"

RUN \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		curl \
		software-properties-common && \
	curl -fsSL https://apt.dockerproject.org/gpg | apt-key add - && \
	add-apt-repository \
		"deb https://apt.dockerproject.org/repo/ debian-$(lsb_release -cs) main" && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

RUN \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		docker-engine \
		openjdk-7-jre-headless \
		openssh-client \
		php5-cgi \
		php5-cli \
		php5-mysql \
		python \
		python-openssl \
		unzip && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

RUN \
	mkdir -p "${HOME}/.ssh" && \
	curl -L -o google-cloud-sdk.zip \
		https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && \
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
