FROM alpine:3.16.2

ARG KUBECTL_VERSION="1.25.0"
ARG TERRAFORM_VERSION="1.2.8"
ARG ARGOCD_VERSION=""
ARG HELM_VERSION="3.9.0"
ARG GITHUB_CLI_VERSION="2.14.7"
ARG AZ_CLI_VERSION="2.39"
ARG AWS_CLI_VERSION="2.2.0"

# updates and upgrades
RUN apk update && \
    apk add --upgrade apk-tools && \
    apk upgrade --available
    
# install from apk
RUN apk add \
	bash \
    unzip \
    curl \
    jq \
    python3 \
    py3-pip \
    git \
    shellcheck \
    yamllint \
    gomplate \
    glab \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev \
    cargo \
    make

# download and install tools fron outside sources
# kubectl
RUN curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
	mv kubectl /usr/local/bin
# terraform
RUN curl -L "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o terraform.zip && \
	unzip terraform.zip && \
	chmod +x terraform && \
	mv terraform /usr/local/bin && \
	rm terraform.zip
# argocd cli
RUN curl -LO "https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64" && \
	chmod +x argocd-linux-amd64 && \
	mv argocd-linux-amd64 /usr/local/bin/argoci
# helm
RUN	curl -L "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" -o helm.tar.gz && \
	tar -zxf helm.tar.gz && \
	mv linux-amd64/helm /usr/local/bin && \
	rm -r linux-amd64 && \
	rm helm.tar.gz
# github cli
RUN curl -LO "https://github.com/cli/cli/releases/download/v${GITHUB_CLI_VERSION}/gh_${GITHUB_CLI_VERSION}_linux_amd64.tar.gz" && \
    tar -zxf gh_${GITHUB_CLI_VERSION}_linux_amd64.tar.gz && \
    mv gh_${GITHUB_CLI_VERSION}_linux_amd64/bin/gh /usr/local/bin && \
	rm gh_${GITHUB_CLI_VERSION}_linux_amd64/bin/gh
# azure cli
RUN pip install --upgrade pip && \
    pip install azure-cli==${AZ_CLI_VERSION}
# aws cli
RUN pip3 install awscliv2==${AWS_CLI_VERSION}

# deploy scripts to be used as helpers for ci jobs
# scripts
COPY scripts/ /usr/local/bin/
RUN chmod -R +x /usr/local/bin/*
