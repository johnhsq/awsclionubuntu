#
# Dockerfile for AWS CLI on Ubuntu with Python, curl, jq
#
# https://github.com/johnhsq/awsclionubuntu
#
# Build
#    $ docker build -f Dockerfile -t johnhsq/awsclionubuntu .
# Check in docker image
#    $ docker login
#    $ docker push johnhsq/awsclionubuntu
# Use
#    In your local linux add the following command alias to your profile (e.g. ~/.bash_profile)
#     alias awscli.test="docker run \
#       -it \
#       --env AWS_ACCESS_KEY_ID= <your aws access key> \
#       --env AWS_SECRET_ACCESS_KEY= <your aws secret key> \
#       --env AWS_DEFAULT_REGION= <your aws default region> \
#       johnhsq/awsclionubuntu /bin/sh"
#   $ source ~/.bash_profile
# Test
#   start AWS CLI
#     $ awscli.test
#   test your AWS environment with the following commands
#     $ python3 --version
#     $ curl --version
#     $ jq --version
#     $ aws --version
#     $ aws iam list-account-aliases
#     $ aws ec2 describe-instances


# Pull base image.
FROM ubuntu:latest

# Install Python
ENV DEBIAN_FRONTEND noninteractive
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends apt-utils && \
  apt-get install -y python python-dev python-pip python3-pip python-virtualenv && \
  pip install --upgrade pip

# Install curl
RUN apt-get -y -qq update && \
	apt-get install -y -qq curl && \
	apt-get install -y -qq groff

# Install ssh
RUN apt-get -y -qq update && \
	apt-get install -y -qq openssh-client

# Install jq to parse json within bash scripts
RUN curl -o /usr/local/bin/jq http://stedolan.github.io/jq/download/linux64/jq && \
  chmod +x /usr/local/bin/jq

# Install AWS CLI
RUN \
  pip3 install awscli --upgrade --user && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND teletype

# add AWS CLI command path
ENV PATH ~/.local/bin:$PATH

# Install useful packages: ssh, vim
RUN \
  apt-get update && \
  apt-get install -y -qq ssh && \
  apt-get install -y -qq vim

# Use bash instead of sh by default
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]
