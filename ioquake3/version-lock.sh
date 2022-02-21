#!/usr/bin/env bash
set -u -o pipefail

VCS_SOURCE="$(git remote get-url --push origin)"
VCS_REVISION="$(git describe --always)"
DATE="$(date --iso-8601=seconds)"
export VCS_SOURCE
export VCS_REVISION
export DATE
export BASE_IMAGE="quay.io/labmonkeys/alpine:3.15.0.b74"
export BUILDER_BASE_IMAGE="quay.io/labmonkeys/alpine:3.15.0.b74"
export GIT_COMMIT="99b66faa0240aa9823d64ac00ef53d347a2e85e1"
