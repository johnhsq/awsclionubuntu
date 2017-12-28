## Docker image with AWS CLI on Ubuntu
This repository contains **Dockerfile** of [AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/installing.html) for Docker published to the public [Docker Hub] (https://hub.docker.com/r/johnhsq/awsclionubuntu/).


### Base Docker Image

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)


### Build

	docker build -f Dockerfile -t johnhsq/awsclionubuntu .

### Usage
In your local linux add the following command alias to your profile (e.g. ~/.bash_profile)

     alias awscli.test="docker run \
       -it \
       --env AWS_ACCESS_KEY_ID= <your aws access key> \
       --env AWS_SECRET_ACCESS_KEY= <your aws secret key> \
       --env AWS_DEFAULT_REGION= <your aws default region> \
       johnhsq/awsclionubuntu /bin/sh"

### Test
Start AWS CLI

     $ awscli.test

Test your AWS environment with the following commands

     # python3 --version
     # curl --version
     # jq --version
     # aws --version
     # aws iam list-account-aliases
     # aws ec2 describe-instances
