FROM python:alpine

MAINTAINER Pawel Niemiec <pniemiec@noledgetech.com>

# Update distribution & install required packages
RUN apk upgrade --no-cache --available \
    && apk add --no-cache \
        bash \
        ca-certificates \
        git \
        curl \
        openssl \
        openssh \
        vim \
        jq \
        gnupg \
        libffi-dev \
        openssl-dev \
        python-dev \
        py-pip \
        build-base \
        alpine-sdk \
        gcc \
        musl-dev \
        linux-headers \
        groff \
        less \
    && rm -rf /var/cache/apk /root/.cache

# Environment variables
ENV OS_VER linux_amd64
ENV PACKER_VER 1.3.5
ENV DRONE_VER v1.0.7
ENV TERRAFORM_VER 0.11.10

# Install packer
RUN wget -q https://releases.hashicorp.com/packer/${PACKER_VER}/packer_${PACKER_VER}_${OS_VER}.zip \
    && unzip packer_${PACKER_VER}_${OS_VER}.zip -d /usr/local/bin/ \
    && packer --version \
    && rm -f packer_${PACKER_VER}_${OS_VER}.zip

# Install Drone CLI
RUN wget -q https://github.com/drone/drone-cli/releases/download/${DRONE_VER}/drone_${OS_VER}.tar.gz \
    && tar xvf drone_${OS_VER}.tar.gz \
    && install -t /usr/local/bin drone \
    && drone --version \
    && rm -rf drone_${OS_VER}.tar.gz ./drone

# Install latest AWS CLI
RUN wget -q https://s3.amazonaws.com/aws-cli/awscli-bundle.zip \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
    && aws --version \
    && rm -rf awscli-bundle*

# Install terraform
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_${OS_VER}.zip \
    && unzip terraform_${TERRAFORM_VER}_${OS_VER}.zip -d /usr/local/bin/ \
    && terraform --version \
    && rm -f terraform_${TERRAFORM_VER}_${OS_VER}.zip

# Install python modules
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY src/ /root
WORKDIR /root

CMD [ "bash" ]
