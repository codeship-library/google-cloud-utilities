FROM ubuntu:18.04

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends python-setuptools python-pip apt-transport-https ca-certificates wget rsync unzip jq git && \
  pip install wheel && \
  pip install ansible==2.4.4.0 pyasn1==0.4.2 ndg-httpsclient==0.4.4 urllib3==1.22 pyOpenSSL==17.3.0

RUN mkdir /root/bin

COPY tasks /google-cloud/tasks
COPY vars /google-cloud/vars
COPY site.yml site.yml
COPY deployment /google-cloud/deployment

RUN ansible-playbook -i localhost -c local site.yml

ENV PATH="/root/bin:/root/google-cloud-sdk/bin:/root/appengine/python_appengine:/root/appengine/go_appengine:/root/appengine/java_appengine/bin:${PATH}"

#for the mvn deploy tests
RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests maven openjdk-8-jdk
