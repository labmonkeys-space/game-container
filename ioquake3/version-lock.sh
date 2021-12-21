#!/usr/bin/env bash
set -u -o pipefail

export VCS_SOURCE="$(git remote get-url --push origin)"
export VCS_REVISION="$(git describe --always)"
export BASE_IMAGE="quay.io/labmonkeys/ubuntu:focal-20211006.b66"
export BUILDER_BASE_IMAGE="quay.io/labmonkeys/cimg-base:20.04-20211130.b33"