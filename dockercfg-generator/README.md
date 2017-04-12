# gcr-dockerfg-generator

Dockercfg generator for GCR

This container allows you to generate a temporary dockercfg using your Google API credentials
and writes it to a specified filename. Typical usage of this image would be to run it 
with a volume attached, and write the dockercfg to that volume. Note that this generator only 
works if you have a local Docker host available. Using a remote Docker host (Docker Machine 
with AWS, etc) will result in an error because the generator writes to your local file system.

```
$ cat gcr_creds.env
GOOGLE_AUTH_EMAIL=gcloud-user@myapp-130450.iam.gserviceaccount.com
GOOGLE_PROJECT_ID=myapp-130450
GOOGLE_AUTH_JSON=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
$ docker run -it -v /home/myuser/data:/opt/data --env-file=gcr_creds.env codeship/gcr-dockercfg-generator /opt/data/gcr.dockercfg
Logging into Google GCR
Activated service account credentials for: [gcloud-user@myapp-130450.iam.gserviceaccount.com]


Updates are available for some Cloud SDK components.  To install them,
please run:
  $ gcloud components update

Syncing GCR credentials
Loading user based configuration file: [/.config/gcloud/properties].
User based configuration files are deprecated and will not be read in a future gcloud release.
ls
Short-lived access for ['gcr.io', 'us.gcr.io', 'eu.gcr.io', 'asia.gcr.io', 'b.gcr.io', 'bucket.gcr.io', 'appengine.gcr.io'] configured.
Writing Docker creds to /opt/data/gcr.dockercfg

$ cat /home/myuser/data/gcr.dockercfg # file is available locally
```

## Using with Codeship

Codeship supports using custom images to generate dockercfg files during the build process. To use this image to integrate with Google GCR, simply define a entry in your services file for this image, and reference it from any steps or services which need to interact with GCR repositories with the `dockercfg_service` field. You'll also need to provide the following environment variables using an [encrypted env file](https://codeship.com/documentation/docker/encryption/):

* GOOGLE_AUTH_EMAIL - The email associated with the Google API credentials
* GOOGLE_PROJECT_ID - The ID associated with the project
* GOOGLE_AUTH_JSON - The API credential JSON file, merged onto a single line

Here is an example of using a GCR Dockercfg generator to authenticate pushing an image.

```
# codeship-services.yml
app:
  build:
    image: gcr.io/project-id/myapp
    dockerfile_path: ./Dockerfile
gcr_dockercfg:
  image: codeship/gcr-dockercfg-generator
  add_docker: true
  encrypted_env_file: gcr.env.encrypted
```

```
- service: app
  type: push
  tag: master
  image_name: gcr.io/project-id/myapp
  registry: https://gcr.io
  dockercfg_service: gcr_dockercfg
```

You can also use this authentication to pull images, or use with caching, by defining the `dockercfg_service` field on groups of steps, or each individual step that pulls or pushes an image, or by adding the field to specific services.

