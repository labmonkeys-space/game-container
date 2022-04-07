#!/usr/bin/env bash
set -u -o pipefail

export VCS_SOURCE="$(git remote get-url --push origin)"
export VCS_REVISION="$(git describe --always)"
export BASE_IMAGE="quay.io/labmonkeys/ubuntu:jammy-20220404.b159"
export CA_CERT_VERSION="20211016"
export BZFS_VERSION="2.4.22-1build1"
