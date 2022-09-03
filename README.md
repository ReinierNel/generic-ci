# generic-ci

Docker container that has most of the tools needed to test, build and deploy things

## Tools installed from Package Manager

* bash
* unzip
* curl
* jq
* python3
* py3-pip
* git
* shellcheck
* yamllint
* gomplate
* glab
* gcc
* musl-dev
* python3-dev
* libffi-dev
* openssl-dev
* cargo
* make

## Tools installed from Direct Download

|**Name**|**Versions**|
|---|---|
|kubectl|1.25.0|
|terraform|1.2.8|
|argocd cli||
|helm|3.9.0|
|github cli|2.14.7|
|azure cli|2.39|
|aws cli|2.7.29|

## Scripts

Scripts are stored under /usr/local/bin and can be invoked from anywhere

### `deploy-kubernetes`

> NOTE: that this script is under contractions

This script deploys kubernetes manifest in a directory to a cluster

#### Requirements

1. Valid .kube/config or other kubernets credentials
2. Location of folder where manifest are located

#### Usage

```bash
deploy-kubernetes "/path/to/k8s/files"
```